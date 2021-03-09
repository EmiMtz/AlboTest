//
//  RangeSliderOneThumbLayer.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit
import QuartzCore

class RangeSliderOneThumbLayer: CALayer {
    var highlighted = true{
        didSet {
            updateLayerFrames()
        }
    }
    weak var rangeSlider: SFRangeSliderOne?
    
    
    func updateLayerFrames() {
        if highlighted {
            self.shadowColor = UIColor.lightGray.cgColor
            self.shadowOffset = .zero
            self.shadowRadius = 3.0
            self.shadowOpacity = 0.7
        }
        else {
            self.shadowColor = UIColor.lightGray.cgColor
            self.shadowOffset = .zero
            self.shadowRadius = 3.0
            self.shadowOpacity = 0.7
        }
    }
}
