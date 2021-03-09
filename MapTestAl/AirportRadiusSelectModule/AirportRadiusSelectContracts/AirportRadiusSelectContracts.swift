//
//  AirportRadiusSelectContracts.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
//Views
protocol AirportRadiusSelectViewControllerProtocol: UIViewController {
    var presenter: AirportRadiusSelectPresenterProtocol? {get set}
    
}
//Interactor
protocol AirportRadiusSelectInteractorProtocol: NSObject {
    var output: AirportRadiusSelectInteractorOutputProtocol? {get set}

}

protocol AirportRadiusSelectInteractorOutputProtocol: NSObject {

}

//Presenter
protocol AirportRadiusSelectPresenterProtocol: NSObject {
    var view: AirportRadiusSelectViewControllerProtocol? {get set}
    var interactor: AirportRadiusSelectInteractorProtocol? {get set}
    var router: AirportRadiusSelectRouterProtocol? {get set}

}
//Router
protocol AirportRadiusSelectRouterProtocol {
    var presenter: AirportRadiusSelectPresenterProtocol? {get set}
    static func createModule() -> UIViewController
    
}

