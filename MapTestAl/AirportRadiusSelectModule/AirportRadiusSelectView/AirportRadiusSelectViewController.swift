//
//  AirportRadiusSelectViewController.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class AirportRadiusSelectViewController: UIViewController,AirportRadiusSelectViewControllerProtocol, CLLocationManagerDelegate {
    
    @IBOutlet weak var numberOfKMLbl: UILabel!
    @IBOutlet weak var radiousSlider: UISlider!
    @IBOutlet weak var searchBtn: ButtonCustom!
    
    var presenter: AirportRadiusSelectPresenterProtocol?
    var radious = 0
    var lat = 0.0
    var lng = 0.0
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        self.configCurrentLocation()
    }
    
    func openTabBar(){
        var userDetail = UserDetailEntity()
        userDetail.lat = CLLocationManager.locationServicesEnabled() ? lat : 25.6714
        userDetail.lng = CLLocationManager.locationServicesEnabled() ? lng : -100.309
        let mapsVC = MapRouter.createModule(radious: radious, userLocation: userDetail) as! MapViewController
        mapsVC.lat = userDetail.lat ?? 0.0
        mapsVC.lng = userDetail.lng ?? 0.0
        
        let item1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        mapsVC.tabBarItem = item1
        
        let infoAirportsVC = AirportTableRouter.createModule(radious: radious, userLocation: userDetail) as! AirportTableViewController
        infoAirportsVC.lat = userDetail.lat ?? 0.0
        infoAirportsVC.lng = userDetail.lng ?? 0.0
        let item2 = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        infoAirportsVC.tabBarItem = item2
        
        let controllers = [mapsVC, infoAirportsVC]
        
        let tabBar = TabBarVC(controllers: controllers)
        tabBar.title = ""
        let navBarAppereance = UINavigationBarAppearance()
        navBarAppereance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.compactAppearance = navBarAppereance
        navigationController?.navigationBar.standardAppearance = navBarAppereance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppereance
        navigationController?.navigationBar.tintColor = .white
        navigationController?.setViewControllers([tabBar], animated: false)
    }
    
    ///Para pedir permisos de ubicación del usuario en caso de que no se hayan dado los permisos al momento de instalar la aplicación.
    func configCurrentLocation(){
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
    
    @IBAction func onMoveSlider(_ sender: Any) {
        radious = Int(radiousSlider.value)
        self.numberOfKMLbl.text = "\(radious)"
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        openTabBar()
    }
}


