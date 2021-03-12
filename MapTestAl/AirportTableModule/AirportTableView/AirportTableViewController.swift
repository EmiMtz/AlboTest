//
//  AirportTableViewController.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 10/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class AirportTableViewController: UIViewController,AirportTableViewControllerProtocol, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var airports: [AirPortEntity] = [AirPortEntity]()
    var presenter: AirportTablePresenterProtocol?
    var zoomCamera: Float = 16.0
    var radious: Int?
    var locationManager = CLLocationManager()
    var lat : Double = 25.6714
    var lng : Double = -100.309
    
    override func viewDidLoad() {
        self.configCurrentLocation()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.loadNearAirport()
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
    @IBAction func onChangeRadious(_ sender: Any) {
        let vc = AirportRadiusSelectRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AirportTableViewController {
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
            self.airports.removeAll()
            airports?.forEach({ (airport) in
                self.airports.append(airport)
            })
            self.tableView.reloadData()
        }
    }
}

extension AirportTableViewController: UITableViewDelegate, UITableViewDataSource {
    ///Regrea el número de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.airports.count
    }
    
    //información a mostrar en la celda.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportCell", for: indexPath ) as! AirportCell
        
        let latAiport = self.airports[indexPath.row].geometry?.location?.lat ?? 0.0
        let lngAirport = self.airports[indexPath.row].geometry?.location?.lng ?? 0.0
        
        let coordinate0 = CLLocation(latitude: self.lat, longitude: self.lng)
        let coordinate1 = CLLocation(latitude: latAiport, longitude: lngAirport)
        let distanceInMeters = Float(coordinate0.distance(from: coordinate1))
        let distanceInKM = String(format: "%.0f", ceil(distanceInMeters / 1000))
        
        cell.airportName.text = self.airports[indexPath.row].name
        cell.airportKM.text =  distanceInKM + " km away"
        
        return cell
    }
    
}
