//
//  AirportTableContracts.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 10/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
//Views
protocol AirportTableViewControllerProtocol: UIViewController {
    var presenter: AirportTablePresenterProtocol? {get set}
    var radious: Int? {get set}
    
    func alertLocation(tit: String, men: String, completion: ((UIAlertAction) -> Void)?)
    func showAirpot(airports: [AirPortEntity]?)
}
//Interactor
protocol AirportTableInteractorProtocol: NSObject {
    var output: AirportTableInteractorOutputProtocol? {get set}
    func getAirport(parmetros: NearbyParameters,completion: @escaping ([AirPortEntity]?,NSError?) -> Void)
}

protocol AirportTableInteractorOutputProtocol: NSObject {

}

//Presenter
protocol AirportTablePresenterProtocol: NSObject {
    var view: AirportTableViewControllerProtocol? {get set}
    var interactor: AirportTableInteractorProtocol? {get set}
    var router: AirportTableRouterProtocol? {get set}
    var userDetail: UserDetailEntity? {get set}
    
    func loadNearAirport()
}
//Router
protocol AirportTableRouterProtocol {
    var presenter: AirportTablePresenterProtocol? {get set}
    static func createModule(radious: Int, userLocation: UserDetailEntity?) -> UIViewController
    
}

