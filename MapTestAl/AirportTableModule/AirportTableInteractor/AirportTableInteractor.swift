//
//  AirportTableInteractor.swift
//  MapTestAl
//
//  Created Emiliano Alfredo Martinez Vazquez on 10/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AirportTableInteractor: NSObject, AirportTableInteractorProtocol {
    
    weak var output: AirportTableInteractorOutputProtocol?

    /// Función para obtener aeropuertos cercanos
    /// - Parameters:
    ///   - parmetros: Lugares cercanos
    ///   - completion: EL lugar del aeropuerto
    func getAirport(parmetros: NearbyParameters, completion: @escaping ([AirPortEntity]?, NSError?) -> Void) {
        let urlServicio = WebRequests.getGoogleURL(.WSNearbySearch)! + parmetros.convertToString()
        
        RequestManager.make(url: urlServicio, metodo: .get) { (responseData: NearPlacesEntity?, code: CodeResponse?, tag: Int) in
            var errorWS : NSError? = nil
            var airPorts : [AirPortEntity]? = nil
            switch code{
            case .ok:
                airPorts = responseData?.results
            default:
                errorWS = NSError(domain:"WSGoogle", code:-1,userInfo: ["message": "El servicio no está disponible, por favor intente más tarde."])
                
            }
            completion(airPorts,errorWS)
        }
    }
}
