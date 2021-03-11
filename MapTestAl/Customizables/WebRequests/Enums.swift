//
//  Enums.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import UIKit

public enum CodeResponse: Int {
    case ok = 200
    case content = 201
    case bad_request = 400
    case server_error = 500
    case unknow = 520
    case not_connection = 106
    case bad_url = -1
    case bad_decodable = -2
    case not_implemented = -3
}

enum ImageMultiType: String {
    case front
}
