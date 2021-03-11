//
//  FontsManager.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import Foundation
import UIKit

enum Fonts: String {
    case ReformationSansRegular = "reformation sans regular"
    case Kermesse = "kermesse"
    case AvenirRegular = "Avenir"
    case AvenirMedium = "Avenir-Medium"
    case AvenirHeavy = "Avenir-Heavy"
    case AvenirBlack = "Avenir-Black"

    func of(size: CGFloat) -> UIFont {
        let font = UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
        return font
    }
}
