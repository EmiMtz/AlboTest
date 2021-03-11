//
//  Response.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import UIKit

struct Response <T:Codable>: Codable
{
    var success : Bool?
    var message: String?
    var statusCode : String?
    var data: T?
    
    enum CodingKeys: String, CodingKey
    {
        case success = "success"
        case message = "message"
        case statusCode = "statusCode"
        case data = "data"
    }
}
