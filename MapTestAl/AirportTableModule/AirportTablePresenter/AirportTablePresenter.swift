//
//  AirportTablePresenter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 10/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportTablePresenter: NSObject, AirportTablePresenterProtocol {
    
    weak var view: AirportTableViewControllerProtocol?
    var interactor: AirportTableInteractorProtocol?
    var router: AirportTableRouterProtocol?

}
extension AirportTablePresenter: AirportTableInteractorOutputProtocol {
    
}
