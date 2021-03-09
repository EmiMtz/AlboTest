//
//  MyMapsPresenter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MyMapsPresenter: NSObject, MyMapsPresenterProtocol {
    
    weak var view: MyMapsViewControllerProtocol?
    var interactor: MyMapsInteractorProtocol?
    var router: MyMapsRouterProtocol?

}
extension MyMapsPresenter: MyMapsInteractorOutputProtocol {
    
}
