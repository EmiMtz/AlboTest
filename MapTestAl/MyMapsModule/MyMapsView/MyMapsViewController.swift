//
//  MyMapsViewController.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MyMapsViewController: UITabBarController,MyMapsViewControllerProtocol,UISearchBarDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var selector: UISegmentedControl!
    
    var presenter: MyMapsPresenterProtocol?
    var radius: Float?
    let locationManager = CLLocationManager()
    
    var searchBarController : UISearchController!
    
    var resultSearchController: UISearchController? = nil
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let geocoder = CLGeocoder()
    var adress = ""
    
    var place = Place()
    
    override func viewDidLoad() {
        self.startMap()
    }
    
    func startMap(){
        let location : CLLocation? = determineUserCurrentLocation()
        if location != nil {
            guard let currentCoordinate = locationManager.location?.coordinate else { return }
            let region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            myMap.setRegion(region, animated: true)
        }else {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo")
        }
    }
    
    func alertLocation(tit: String, men: String)  {
        let alerta = UIAlertController(title: tit, message: men,preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
    ///Función que determina la ubicación actual del usuario.
    func determineUserCurrentLocation()->CLLocation?{
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 13.0, *) {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            return locationManager.location
        }
        else{
            return nil
        }
    }
    
    @IBAction func changeLook(_ sender: Any) {
        //ESTRUCTURA DE CASOS
        switch selector.selectedSegmentIndex {
        case 0:
            myMap.mapType = .standard
            
        case 1:
            myMap.mapType = .satellite
            
        case 2:
            myMap.mapType = .hybrid
            
        default:
            break
        }
    }
    
    @objc func action(gestureRecognizer: UIGestureRecognizer) {
        
        self.myMap.removeAnnotations(myMap.annotations)
        
        let touchPoint = gestureRecognizer.location(in: myMap)
        let newCoords = myMap.convert(touchPoint, toCoordinateFrom: myMap)
        
        geocoderLocation(newLocation: CLLocation(latitude: newCoords.latitude, longitude: newCoords.longitude))
        
        let latitud = String(format: "%.6f", newCoords.latitude)
        let longitud = String(format: "%.6f", newCoords.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoords
        annotation.title = adress
        annotation.subtitle = "Latitud: \(latitud), Longitud \(longitud)"
        myMap.addAnnotation(annotation)
        
        let sourceCoordinates = locationManager.location?.coordinate
        let destCoordinates = CLLocationCoordinate2DMake(newCoords.latitude, newCoords.longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .transit
        directionRequest.transportType = .any
        
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            
            response, error in
            
            guard let response = response else {
                if error != nil {
                    let alert = UIAlertController(title: nil, message: "Directions not available.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel) { (alert) -> Void in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true,completion: nil)
                }
            return
            }
            
            
            if self.myMap.overlays.count > 1 {
                self.myMap.removeOverlays(self.myMap.overlays)
            }
            
            let route = response.routes[0]
            self.myMap.addOverlay(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.myMap.setRegion(MKCoordinateRegion(rekt), animated: true)
        })
        


        
    }
    
    @objc func doubleTapped() {
        self.myMap.removeAnnotations(myMap.annotations)
        self.myMap.removeOverlays(myMap.overlays)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange.withAlphaComponent(0.45)
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    func geocoderLocation(newLocation: CLLocation) {
        var dir = ""
        geocoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if error == nil {
                dir = "No se ha podido determinar la dirección"
            }
            if let placemark = placemarks?.last {
                dir = self.stringFromPlacemark(placemark: placemark)
            }
            self.adress = dir
        }
    }
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        var line = ""
        
        if let p = placemark.thoroughfare {
            line += p + ", "
        }
        if let p = placemark.subThoroughfare {
            line += p + " "
        }
        if let p = placemark.locality {
            line += " (" + p + ")"
        }
        return line
    }
}

extension MyMapsViewController : CLLocationManagerDelegate {
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print(locations[0])
    }
    
    @IBAction func showSearchBar(){
        searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.hidesNavigationBarDuringPresentation = false
        
        self.searchBarController.searchBar.delegate = self
        present(searchBarController, animated: true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.sizeToFit()
        
        
        dismiss(animated: true, completion: nil)
        
        
        
        if myMap.annotations.count > 1 {
            self.myMap.removeAnnotations(myMap.annotations)
        }
        
        geocoder.geocodeAddressString(searchBar.text!){ (placemarks:[CLPlacemark]?, error:Error?) in
            
            if error == nil {
                let placemark = placemarks?.first
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location?.coordinate)!
                annotation.title = searchBar.text!
                
                let spam = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: spam)
                
                self.myMap.setRegion(region, animated: true)
                self.myMap.addAnnotation(annotation)
                self.myMap.selectAnnotation(annotation, animated: true)
                
                let sourceCoordinates = self.locationManager.location?.coordinate
                let destCoordinates = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
                
                let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
                let destPlacemark = MKPlacemark(coordinate: destCoordinates)
                
                let sourceItem = MKMapItem(placemark: sourcePlacemark)
                let destItem = MKMapItem(placemark: destPlacemark)
                
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceItem
                directionRequest.destination = destItem
                directionRequest.transportType = .transit
                directionRequest.transportType = .any
                
                
                let directions = MKDirections(request: directionRequest)
                directions.calculate(completionHandler: {
                    
                    response, error in
                    
                    guard let response = response else {
                        if error != nil {
                            let alert = UIAlertController(title: nil, message: "Directions not available.", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: "OK", style: .cancel) { (alert) -> Void in
                                self.navigationController?.popViewController(animated: true)
                            }
                            alert.addAction(okButton)
                            self.present(alert, animated: true,completion: nil)
                        }
                        return
                    }
                    
                    
                    if self.myMap.overlays.count > 1 {
                        self.myMap.removeOverlays(self.myMap.overlays)
                    }
                    
                    let route = response.routes[0]
                    self.myMap.addOverlay(route.polyline, level: .aboveRoads)
                    
                    let rekt = route.polyline.boundingMapRect
                    self.myMap.setRegion(MKCoordinateRegion(rekt), animated: true)
                })
                
            } else {
                print("Error")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }

}

extension MyMapsViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        //searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension MyMapsViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let annotationID = "AnnotationID"
        
        var annotationView : MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID){
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "img_pin")
        }
        return annotationView
        }
}



extension MyMapsViewController{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

}

