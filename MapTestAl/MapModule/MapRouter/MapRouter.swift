//
//  MapRouter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MapRouter: MapRouterProtocol {
    
    weak var presenter: MapPresenterProtocol?
    
    static func createModule(radious: Int, userLocation: UserDetailEntity?)-> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "Map") as! MapViewControllerProtocol
        let presenter: MapPresenterProtocol & MapInteractorOutputProtocol = MapPresenter()
        let interactor:MapInteractorProtocol = MapInteractor()
        var router: MapRouterProtocol = MapRouter()
        
        view.radious = radious
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.userDetail = userLocation
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "MapStoryboard", bundle: nil)
    }
}
