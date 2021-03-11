//
//  AirportListPresenter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportListPresenter: NSObject, AirportListPresenterProtocol {
    
    weak var view: AirportListViewControllerProtocol?
    var interactor: AirportListInteractorProtocol?
    var router: AirportListRouterProtocol?

}
extension AirportListPresenter: AirportListInteractorOutputProtocol {
    
}
