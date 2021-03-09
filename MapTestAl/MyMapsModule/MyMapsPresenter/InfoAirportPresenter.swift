//
//  InfoAirportPresenter.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

class InfoAirportPresenter: NSObject, InfoAirportPresenterProtocol {
    
    weak var view: InfoAirportViewControllerProtocol?
    var interactor: InfoAirportInteractorProtocol?
    var router: InfoAirportRouterProtocol?

}
extension InfoAirportPresenter: InfoAirportInteractorOutputProtocol {
    
}
