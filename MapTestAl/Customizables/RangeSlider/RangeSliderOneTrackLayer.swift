//
//  RangeSliderOneTrackLayer.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit
import QuartzCore

class RangeSliderOneTrackLayer: CALayer {
    weak var rangeSlider: SFRangeSliderOne?
    

        
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            // Clip
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // Fill the track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
        }
    }

}
