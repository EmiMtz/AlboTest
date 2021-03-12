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
    
}
//Interactor
protocol AirportTableInteractorProtocol: NSObject {
    var output: AirportTableInteractorOutputProtocol? {get set}

}

protocol AirportTableInteractorOutputProtocol: NSObject {

}

//Presenter
protocol AirportTablePresenterProtocol: NSObject {
    var view: AirportTableViewControllerProtocol? {get set}
    var interactor: AirportTableInteractorProtocol? {get set}
    var router: AirportTableRouterProtocol? {get set}

}
//Router
protocol AirportTableRouterProtocol {
    var presenter: AirportTablePresenterProtocol? {get set}
    static func createModule() -> UIViewController
    
}

