//
//  AirportListContracts.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
//Views
protocol AirportListViewControllerProtocol: UIViewController {
    var presenter: AirportListPresenterProtocol? {get set}
    var radious: Int? {get set}
}
//Interactor
protocol AirportListInteractorProtocol: NSObject {
    var output: AirportListInteractorOutputProtocol? {get set}

}

protocol AirportListInteractorOutputProtocol: NSObject {

}

//Presenter
protocol AirportListPresenterProtocol: NSObject {
    var view: AirportListViewControllerProtocol? {get set}
    var interactor: AirportListInteractorProtocol? {get set}
    var router: AirportListRouterProtocol? {get set}

}
//Router
protocol AirportListRouterProtocol {
    var presenter: AirportListPresenterProtocol? {get set}
    static func createModule(radious: Int) -> UIViewController
    
}

