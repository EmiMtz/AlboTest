//
//  MapPresenter.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 09/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MapPresenter: NSObject, MapPresenterProtocol {
    
    var userDetail: UserDetailEntity?
    weak var view: MapViewControllerProtocol?
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    /// Buscar aeropuertos cercanos
    func loadNearAirport() {
        view?.parent?.showIndicator()
        let radius = (self.view?.radious ?? 0) * 1000
        let parametros = NearbyParameters()
        parametros.latitud = userDetail?.lat ?? 0.0
        parametros.longitud = userDetail?.lng ?? 0.0
        parametros.components = true
        parametros.keyword = "airport"
        parametros.type = "airport"
        parametros.radius = Double(radius)
     
        interactor?.getAirport(parmetros: parametros, completion: { (aeropuertos, error) in
            self.view?.parent?.hideIndicator()
            if error != nil{
                self.view?.alertLocation(tit: "Error", men: (error?.userInfo["message"] as! String), completion: { (alert: UIAlertAction!) in
                    self.loadNearAirport()
                })
            }else{
                let filterAirports = aeropuertos?.filter{($0.name?.uppercased().contains("AIRPORT") ?? false)}
                self.view?.showAirpot(airports: filterAirports ?? [])
            }
            
        })
    }

}
extension MapPresenter: MapInteractorOutputProtocol {
    
}
