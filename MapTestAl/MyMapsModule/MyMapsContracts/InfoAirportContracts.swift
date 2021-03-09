//
//  InfoAirportContracts.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit
//Views
protocol InfoAirportViewControllerProtocol: UIViewController {
    var presenter: InfoAirportPresenterProtocol? {get set}
    var radius: Float? {get set}
}
//Interactor
protocol InfoAirportInteractorProtocol: NSObject {
    var output: InfoAirportInteractorOutputProtocol? {get set}

}

protocol InfoAirportInteractorOutputProtocol: NSObject {

}

//Presenter
protocol InfoAirportPresenterProtocol: NSObject {
    var view: InfoAirportViewControllerProtocol? {get set}
    var interactor: InfoAirportInteractorProtocol? {get set}
    var router: InfoAirportRouterProtocol? {get set}

}
//Router
protocol InfoAirportRouterProtocol {
    var presenter: InfoAirportPresenterProtocol? {get set}
    static func createModule(radius: Float) -> UIViewController
    
}

