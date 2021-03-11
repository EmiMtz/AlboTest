//
//  CustomLoader.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class CustomLoader: MDCActivityIndicator {
    func configLoader(){
        self.sizeToFit()
        self.radius = 30.0;
        self.strokeWidth = 4
        self.cycleColors = [UIColor.red]
        self.backgroundColor = UIColor(white: 1, alpha: 0.7)//UIColor(hexString: "#000", alpha: 0.3)
    }

}
