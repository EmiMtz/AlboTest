//
//  AirportRadiusSelectPresenter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportRadiusSelectPresenter: NSObject, AirportRadiusSelectPresenterProtocol {
    
    weak var view: AirportRadiusSelectViewControllerProtocol?
    var interactor: AirportRadiusSelectInteractorProtocol?
    var router: AirportRadiusSelectRouterProtocol?

}
extension AirportRadiusSelectPresenter: AirportRadiusSelectInteractorOutputProtocol {
    
}
