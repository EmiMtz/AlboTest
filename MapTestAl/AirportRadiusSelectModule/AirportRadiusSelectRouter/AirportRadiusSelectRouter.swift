//
//  AirportRadiusSelectRouter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportRadiusSelectRouter: AirportRadiusSelectRouterProtocol {
    
    weak var presenter: AirportRadiusSelectPresenterProtocol?
    
    static func createModule() -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "AirportRadiusSelect") as! AirportRadiusSelectViewControllerProtocol
        let presenter: AirportRadiusSelectPresenterProtocol & AirportRadiusSelectInteractorOutputProtocol = AirportRadiusSelectPresenter()
        let interactor:AirportRadiusSelectInteractorProtocol = AirportRadiusSelectInteractor()
        var router: AirportRadiusSelectRouterProtocol = AirportRadiusSelectRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "AirportRadiusSelectStoryboard", bundle: nil)
    }
}
