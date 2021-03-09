//
//  MyMapsRouter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 08/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MyMapsRouter: MyMapsRouterProtocol {
    
    weak var presenter: MyMapsPresenterProtocol?
    
    static func createModule(radius: Float) -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "MyMaps") as! MyMapsViewControllerProtocol
        let presenter: MyMapsPresenterProtocol & MyMapsInteractorOutputProtocol = MyMapsPresenter()
        let interactor:MyMapsInteractorProtocol = MyMapsInteractor()
        var router: MyMapsRouterProtocol = MyMapsRouter()
        
        view.radius = radius
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "MyMapsStoryboard", bundle: nil)
    }
}
