//
//  MapViewController.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class MapViewController: UIViewController,MapViewControllerProtocol, CLLocationManagerDelegate {
    
    @IBOutlet weak var myLocationBtn: UIButton!
    @IBOutlet weak var myMap: GMSMapView!
    
    var zoomCamera: Float = 16.0
    var presenter: MapPresenterProtocol?
    var radious: Int?
    var locationManager = CLLocationManager()
    var lat : Double = 25.6714
    var lng : Double = -100.309
    
    override func viewDidLoad() {
        self.configCurrentLocation()
        self.presenter?.loadNearAirport()
        self.showMyLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func showMyLocation(){
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng), zoom: 10.0)
        self.myMap.camera = camera
        self.myMap.animate(to: camera)
        self.myMap.clear()
        let marker = GMSMarker()
        marker.position = camera.target
        marker.icon = #imageLiteral(resourceName: "ic_location")
        marker.map = myMap
        marker.appearAnimation = GMSMarkerAnimation.none
    }
    
    ///Para pedir permisos de ubicación del usuario en caso de que no se hayan dado los permisos al momento de instalar la aplicación.
    func configCurrentLocation(){
        let locationManager = CLLocationManager()
        if #available(iOS 13.0, *) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.lng = locValue.longitude
    }
}

extension MapViewController: GMSMapViewDelegate{
    
}

extension MapViewController {
    func alertLocation(tit: String, men: String, completion: ((UIAlertAction) -> Void)?)  {
        let alerta = UIAlertController(title: tit, message: men,preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: completion)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
    func showAirpot(airports: [AirPortEntity]?) {
        if airports?.count == 0 {
            self.alertLocation(tit: "Sin Resultados", men: "No pudimos encontrar ningun resultado", completion: nil)
        } else {
            airports?.forEach({ (airport) in
                let location = CLLocationCoordinate2D(latitude: airport.geometry?.location?.lat ?? 0.0, longitude: airport.geometry?.location?.lng ?? 0.0)
                print("location: \(location)")
                let marker = GMSMarker()
                marker.position = location
                marker.snippet = airport.name ?? ""
                marker.map = myMap
            })
        }
    }
}


