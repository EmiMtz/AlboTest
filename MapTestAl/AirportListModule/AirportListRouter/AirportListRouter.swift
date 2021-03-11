//
//  AirportListRouter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportListRouter: AirportListRouterProtocol {
    
    weak var presenter: AirportListPresenterProtocol?
    
    static func createModule(radious: Int) -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "AirportList") as! AirportListViewControllerProtocol
        let presenter: AirportListPresenterProtocol & AirportListInteractorOutputProtocol = AirportListPresenter()
        let interactor:AirportListInteractorProtocol = AirportListInteractor()
        var router: AirportListRouterProtocol = AirportListRouter()
        
        view.radious = radious
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "AirportListStoryboard", bundle: nil)
    }
}
