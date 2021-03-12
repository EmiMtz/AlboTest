//
//  RequestManager.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import Foundation
import Alamofire

// Clase para realizar peticiones genericas
class RequestManager {
    typealias Metodo = HTTPMethod
    /// crea un request generico con la información proporcionada
    /// - Parameter url: Url a la cual se le hara la petición
    /// - Parameter metodo: Selección de metodo HTTP por utilizar
    /// - Parameter parametros: Contenido que llevara la petición en caso de ser nil no tendra contenido, default nil
    /// - Parameter tipoResultado: Tipo de encodable utilizado para la respuesta, en caso de ser nil, se regresara un success con contenido vacio, default nil
    /// - Parameter delegate: Delegado que recibira las respuestas de la petición
    /// - Parameter tag: Tag que permite operaciones de tipo bandera
    static func make<A:Encodable, T:Codable>(url:String, metodo:Metodo, parametros:A?, headers: [String:String]? = nil, tag:Int = 0, completion: @escaping (T?,CodeResponse?,Int) -> ()) {
        guard let urlForRequest = URL(string: url) else {
            print("WRONG URL \(url)")
            completion(nil,CodeResponse.bad_url,tag)
            return
        }
        guard NetworkReachabilityManager()!.isReachable else {
            completion(nil,CodeResponse.not_connection,tag)
            return
        }
        var urlRequest:URLRequest = URLRequest(url: urlForRequest)
        urlRequest.httpMethod = metodo.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 35
        
        for header in headers ?? [:]{
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if metodo != .get {
            if let contenido = parametros {
                urlRequest.httpBody = try? JSONEncoder().encode(contenido)
            }
        }
        
        print(urlRequest)
        Alamofire.request(urlRequest).responseData { (data) in
            
            switch data.result {
            case .success:
                guard let response = data.response, let value = data.data else {
                    
                    completion(nil,CodeResponse.unknow,tag)
                    
                    return
                }
                
                let code = CodeResponse(rawValue: response.statusCode) ?? CodeResponse.unknow
                if code == .unknow { print("Code not implemented \(response.statusCode)") }
                if (code == .ok) || (code == .content){
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: value)
                        completion(obj,code,tag)
                    }
                    catch let jsonError{
                        print("Falied to decode Json: ",jsonError)
                        completion(nil,.bad_decodable,tag)
                    }
                } else {
                    print("Some code \(response.statusCode)")
                    let obj = try? JSONDecoder().decode(T.self, from: value)
                    completion(obj,code,tag)
                    
                }
            case .failure:
                completion(nil,.unknow,tag)
                
            }
        }
    }
    
    
    
    
    static func make<T:Codable>(url:String,metodo:Metodo,headers: [String:String]? = nil,tag: Int = 0,completion: @escaping (T?,CodeResponse?,Int)-> ()){
        let c : DummyCodable? = nil
        self.make(url: url, metodo: metodo, parametros: c, headers: headers, tag: tag, completion:  completion)
    }
    
    
    /// crea un request generico con la información proporcionada
    /// - Parameter url: Url a la cual se le hara la petición
    /// - Parameter metodo: Selección de metodo HTTP por utilizar
    /// - Parameter parametros: Contenido que llevara la petición en caso de ser nil no tendra contenido, default nil
    /// - Parameter tipoResultado: Tipo de encodable utilizado para la respuesta, en caso de ser nil, se regresara un success con contenido vacio, default nil
    /// - Parameter delegate: Delegado que recibira las respuestas de la petición
    /// - Parameter tag: Tag que permite operaciones de tipo bandera
    static func makeRequest<A:Encodable, T:Codable>(url:String, metodo:Metodo, parametros:A?, headers: [String:String]? = nil, tag:Int = 0, completion: @escaping (T?,CodeResponse?,Int) -> ()) {
        guard let urlForRequest = URL(string: url) else {
            print("WRONG URL \(url)")
            completion(nil,CodeResponse.bad_url,tag)
            return
        }
        guard NetworkReachabilityManager()!.isReachable else {
            completion(nil,CodeResponse.not_connection,tag)
            return
        }
        var urlRequest:URLRequest = URLRequest(url: urlForRequest)
        urlRequest.httpMethod = metodo.rawValue
        urlRequest.timeoutInterval = 35
        //           urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for header in headers ?? [:]{
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if let contenido = parametros {
            urlRequest.httpBody = try? JSONEncoder().encode(contenido)
        }
        
        print(urlRequest)
        
        
        Alamofire.request(urlForRequest, method: metodo, parameters: try? parametros?.asDictionary(), encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let statusCode : CodeResponse = CodeResponse(rawValue: response.response?.statusCode ?? 520) ?? CodeResponse.unknow
            switch statusCode {
            case .ok:
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                    completion(obj,statusCode,tag)
                }
                catch let jsonError{
                    print("Falied to decode Json: ",jsonError)
                    completion(nil,.bad_decodable,tag)
                }
                break
            case .content:
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                    completion(obj,statusCode,tag)
                }
                catch let jsonError{
                    print("Falied to decode Json: ",jsonError)
                    completion(nil,.bad_decodable,tag)
                }
                break
            default :
                completion(nil,statusCode,tag)
                break
                
            }
        }
        
    }
    
    /// crea un request generico con la información proporcionada
    /// - Parameter url: Url a la cual se le hara la petición
    /// - Parameter metodo: Selección de metodo HTTP por utilizar
    /// - Parameter parametros: Contenido que llevara la petición en caso de ser nil no tendra contenido, default nil
    /// - Parameter tipoResultado: Tipo de encodable utilizado para la respuesta, en caso de ser nil, se regresara un success con contenido vacio, default nil
    /// - Parameter delegate: Delegado que recibira las respuestas de la petición
    /// - Parameter tag: Tag que permite operaciones de tipo bandera
    static func makeGetRequest<T:Codable>(url:String,headers:HTTPHeaders?, tag:Int = 0, completion: @escaping (T?,CodeResponse?,Int) -> ()) {
        guard let urlForRequest = URL(string: url) else {
            print("WRONG URL \(url)")
            completion(nil,CodeResponse.bad_url,tag)
            return
        }
        guard NetworkReachabilityManager()!.isReachable else {
            completion(nil,CodeResponse.not_connection,tag)
            return
        }
        let urlRequest:URLRequest = URLRequest(url: urlForRequest)
        
        print(urlRequest)
        
        Alamofire.request(urlForRequest, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let statusCode : CodeResponse = CodeResponse(rawValue: response.response?.statusCode ?? 520) ?? CodeResponse.unknow
            switch statusCode {
            case .ok:
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                    completion(obj,statusCode,tag)
                }
                catch let jsonError{
                    print("Falied to decode Json: ",jsonError)
                    completion(nil,.bad_decodable,tag)
                }
                break
            case .content:
                do {
                    let obj = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                    completion(obj,statusCode,tag)
                }
                catch let jsonError{
                    print("Falied to decode Json: ",jsonError)
                    completion(nil,.bad_decodable,tag)
                }
                break
            default :
                completion(nil,statusCode,tag)
                break
                
            }
        }
        
    }
    
    
    static func makeMultipart<T:Codable>(url:String,imagenes: [ImageMulti]?,parametros: [String:Data]?,metodo: Metodo? = .post ,headers: [String:String]? = nil,completion: @escaping (T?,CodeResponse?) -> ()){
        guard let urlForRequest = URL(string: url) else {
            print("WRONG URL \(url)")
            completion(nil,CodeResponse.bad_url)
            return
        }
        guard NetworkReachabilityManager()!.isReachable else {
            completion(nil,CodeResponse.not_connection)
            return
        }
        var urlRequest:URLRequest = URLRequest(url: urlForRequest)
        urlRequest.httpMethod = metodo?.rawValue
        //urlRequest.timeoutInterval = 15
        
        for header in headers ?? [:]{
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        
        Alamofire.upload(multipartFormData: { (multipart) in
            
            for (key, value) in parametros ?? [:] {
                multipart.append(value, withName: key as String)
            }
            for image in imagenes ?? []{
                if let data = image.data!.jpegData(compressionQuality: 0.75){
                    multipart.append(data, withName: image.type!.rawValue,fileName: "file.jpeg", mimeType: "image/jpeg")
                }
            }
            
        }, with: urlRequest) { (result) in
            
            switch result{
            case .success(let upload,_, _):
                
                upload.responseData { (response) in
                    let statusCode : CodeResponse = CodeResponse(rawValue: response.response?.statusCode ?? 520) ?? CodeResponse.unknow
                    
                    switch statusCode {
                    case .ok:
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                            completion(obj,statusCode)
                        }
                        catch let jsonError{
                            print("Falied to decode Json: ",jsonError)
                            completion(nil,.bad_decodable)
                        }
                        break
                    case .content:
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: response.data ?? Data())
                            completion(obj,statusCode)
                        }
                        catch let jsonError{
                            print("Falied to decode Json: ",jsonError)
                            completion(nil,.bad_decodable)
                        }
                        break
                    default :
                        completion(nil,statusCode)
                        break
                        
                    }
                    
                }
                print("")
            case .failure(_):
                completion(nil,.server_error)
            }
        }
        
    }
    
}

class DummyCodable: Encodable,Decodable{}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}


struct ImageMulti{
    var name: String?
    var data: UIImage?
    var type: ImageMultiType?
}
