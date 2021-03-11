//
//  placeEntity.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 09/03/21.
//

import Foundation

/// El objeto para recibir los objetos de google
class AirPortEntity: Codable{
    var id: String?
    var name: String?
    var formatted_address: String?
    var place_id: String?
    var types: [String]?
    var rating: Float?
    var geometry: GeotryEntity?
    var isSelected: Bool?
    var utc_offset: Int?
}

/// La localizacion del lugar en el mapa
class GeotryEntity: Codable{
    var location:LocationEntity?
}

/// coordenadas de una ubicacion
class LocationEntity: Codable{
    var lat: Double?
    var lng: Double?
}

/// Objeto para los lugares de google
class NearbyParameters: Encodable{
    //var key: String?
    var components: Bool?
    var type: String?
    var types: String?
    var language: String?
    var latitud: Double?
    var longitud: Double?
    var keyword: String?
    var radius: Double?
    var placeID: String?
    var inputStr: String?
    
    
    /// Convertir a string los parametros
    /// - Returns: un string con los arreglos acomodados
    func convertToString() -> String{
        var strParams = "/json?key=\(Constants.googleApiKey)"
        
        if let lon = latitud, let lat = longitud{
            strParams += "&location=\(lon),\(lat)"
        }
        if let radio = radius{
            strParams += "&radius=\(radio)"
        }
        if let leng = language{
            strParams += "&language=\(leng)"
        }
        if let type = types{
            strParams += "&types=\(type)"
        }
        if let type = type{
            strParams += "&type=\(type)"
        }
        if components ?? false{
            //Add us to this
            strParams += "&components=country:mx"
        }
        if let kwd = keyword{
            strParams += "&keyword=\(kwd)"
        }
        if let id = placeID{
            strParams += "&place_id=\(id)"
        }
        if let input = inputStr{
            let escapedText = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            strParams += "&input=\(escapedText)"
        }
        return strParams
    }
    
}

/// Lugares cercanos
class NearPlacesEntity: Codable{
    var next_page_token: String?
    var results: [AirPortEntity]?
    var status: String?
}

/// El detalle de un lugar seleccionado
class PlaceDetailEntity:Codable{
    var result: AirPortEntity?
    var status: String?
}
