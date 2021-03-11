//
//  MapContracts.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
//Views
protocol MapViewControllerProtocol: UIViewController {
    var presenter: MapPresenterProtocol? {get set}
    var radious: Int? {get set}
    
    func alertLocation(tit: String, men: String, completion: ((UIAlertAction) -> Void)?)
    func showAirpot(airports: [AirPortEntity]?)
}
//Interactor
protocol MapInteractorProtocol: NSObject {
    var output: MapInteractorOutputProtocol? {get set}
    func getAirport(parmetros: NearbyParameters,completion: @escaping ([AirPortEntity]?,NSError?) -> Void)
}

protocol MapInteractorOutputProtocol: NSObject {

}

//Presenter
protocol MapPresenterProtocol: NSObject {
    var view: MapViewControllerProtocol? {get set}
    var interactor: MapInteractorProtocol? {get set}
    var router: MapRouterProtocol? {get set}
    var userDetail: UserDetailEntity? {get set}

    func loadNearAirport()
}
//Router
protocol MapRouterProtocol {
    var presenter: MapPresenterProtocol? {get set}
    static func createModule(radious: Int, userLocation: UserDetailEntity?) -> UIViewController
    
}

