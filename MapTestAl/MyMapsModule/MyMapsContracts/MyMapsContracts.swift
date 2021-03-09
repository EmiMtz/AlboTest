//
//  MyMapsContracts.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
//Views
protocol MyMapsViewControllerProtocol: UIViewController {
    var presenter: MyMapsPresenterProtocol? {get set}
    var radius: Float? {get set}
}
//Interactor
protocol MyMapsInteractorProtocol: NSObject {
    var output: MyMapsInteractorOutputProtocol? {get set}

}

protocol MyMapsInteractorOutputProtocol: NSObject {

}

//Presenter
protocol MyMapsPresenterProtocol: NSObject {
    var view: MyMapsViewControllerProtocol? {get set}
    var interactor: MyMapsInteractorProtocol? {get set}
    var router: MyMapsRouterProtocol? {get set}

}
//Router
protocol MyMapsRouterProtocol {
    var presenter: MyMapsPresenterProtocol? {get set}
    static func createModule(radius: Float) -> UIViewController
    
}

