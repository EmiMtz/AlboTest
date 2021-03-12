//
//  AirportTableRouter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 10/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportTableRouter: AirportTableRouterProtocol {
    
    weak var presenter: AirportTablePresenterProtocol?
    
    static func createModule() -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "AirportTable") as! AirportTableViewControllerProtocol
        var presenter: AirportTablePresenterProtocol & AirportTableInteractorOutputProtocol = AirportTablePresenter()
        var interactor:AirportTableInteractorProtocol = AirportTableInteractor()
        var router: AirportTableRouterProtocol = AirportTableRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "AirportTableStoryboard", bundle: nil)
    }
}
