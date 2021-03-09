//
//  InfoAirportsRouter.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

class InfoAirportRouter: InfoAirportRouterProtocol {
    
    weak var presenter: InfoAirportPresenterProtocol?
    
    static func createModule(radius: Float) -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "InfoAirport") as! InfoAirportViewControllerProtocol
        let presenter: InfoAirportPresenterProtocol & InfoAirportInteractorOutputProtocol = InfoAirportPresenter()
        let interactor:InfoAirportInteractorProtocol = InfoAirportInteractor()
        var router: InfoAirportRouterProtocol = InfoAirportRouter()
        
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
