//
//  WebRequests.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 09/03/21.
//

import UIKit
import Foundation
import Alamofire

class WebRequests: NSObject {
    
    static let mapsURL = "https://maps.googleapis.com/maps"
    
    public enum ServiciosGoogle:String{
        case WSNearbySearch = "api/place/nearbysearch"
        case WSPlaceDetail = "api/place/details"
        case WSAutoComplete = "api/place/autocomplete"
        case WSGeocode = "api/geocode/"
    }
    
    static func getGoogleURL(_ method: ServiciosGoogle) -> String?
    {
        let methodName =  method.rawValue
        if methodName == ""
        {
            return nil
        }
        
        var requestURL: String
        
        requestURL = mapsURL +
        "/\(methodName)"
        print("URL COMPLETA: \(requestURL)")
        return requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
    }
    
    static func isConnectedToInternet()->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
