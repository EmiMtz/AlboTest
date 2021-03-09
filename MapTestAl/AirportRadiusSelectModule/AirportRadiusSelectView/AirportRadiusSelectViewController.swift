//
//  AirportRadiusSelectViewController.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportRadiusSelectViewController: UIViewController,AirportRadiusSelectViewControllerProtocol {
    
    @IBOutlet weak var numberOfKMLbl: UILabel!
    @IBOutlet weak var radiousSlider: UISlider!
    @IBOutlet weak var searchBtn: ButtonCustom!
    
    var presenter: AirportRadiusSelectPresenterProtocol?
    var radious = 0
    
    override func viewDidLoad() {
        
    }
    
    func openTabBar(){
        let mapsVC = MyMapsRouter.createModule(radius: Float(radious))
        let item1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        mapsVC.tabBarItem = item1
        
        let infoAirportsVC = InfoAirportRouter.createModule(radius: Float(radious))
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
    
    @IBAction func onMoveSlider(_ sender: Any) {
        radious = Int(radiousSlider.value)
        self.numberOfKMLbl.text = "\(radious)"
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        self.openTabBar()
    }
}


