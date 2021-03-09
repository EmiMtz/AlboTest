//
//  RangeSlider.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit
import QuartzCore

protocol changeValue {
    func valueChanged(_ value: Int?)
}

class SFRangeSliderOne: UIControl {

    var delegate: changeValue?
    
    var minimumValue = 0.0{
        didSet {
            updateLayerFrames()
        }
    }
    
    var maximumValue = 1.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var lowerValue = 0.0{
        didSet {
            updateLayerFrames()
        }
    }
    
    var currentStep = 0{
        didSet{
            upperValue = Double((currentStep * 125)) / 1000.0
            sendActions(for: .valueChanged)
        }
    }
    var upperValueTemp = 0.0
    
    
    var upperValue = 0.0{
        didSet {
            updateLayerFrames()
        }
    }
    
    let trackLayer = RangeSliderOneTrackLayer()
    let lowerThumbLayer = RangeSliderOneThumbLayer()
    let upperThumbLayer = RangeSliderOneThumbLayer()

    var thumbHeight: CGFloat {
        return CGFloat(bounds.height)
    }
    
    private var thumbWidth : CGFloat {
        return thumbHeight * 0.5
    }
    
    //Touch Handlers
    var previousLocation = CGPoint()
    
    
//        return self.currentStep
//    }

    
    var trackTintColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0){
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var thumbTintColor = UIColor.white{
        didSet {
            upperThumbLayer.setNeedsDisplay()
        }
    }

    var curvaceousness : CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.initialize()
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    func initialize (){
//        let currentStep = 8
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        upperThumbLayer.rangeSlider = self
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)

        upperThumbLayer.backgroundColor = UIColor.white.cgColor
    }
    
    func updateLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)


        
        let upperThumbCenter =  CGFloat(positionForValue(upperValue))
      
        upperThumbLayer.frame = CGRect(x: upperThumbCenter, y: 0.0, width: thumbWidth, height: thumbHeight)
        upperThumbLayer.cornerRadius = thumbHeight * 0.25
        upperThumbLayer.setNeedsDisplay()
        upperThumbLayer.shadowColor = UIColor.lightGray.cgColor
        upperThumbLayer.shadowOffset = .zero
        upperThumbLayer.shadowRadius = 3.0
        upperThumbLayer.shadowOpacity = 0.7
        
            
        CATransaction.commit()

    }
    
    func positionForValue(_ value:Double) ->Double{
        return (Double(bounds.width) *  value) - Double((thumbWidth * 0.5))
    }
    
    func drawTicks(in rect: CGRect, context ctx: CGContext) {
        
            
        let majorTickColor = UIColor.init(named: "#9D9D9D")
        let majorTickWidth: CGFloat = 3
        let majorTickLength: CGFloat = 20

            //draw major ticks
        ctx.setLineWidth(majorTickWidth)
        majorTickColor?.set()

        let majorEnd = bounds.height + 2
        let majorStart = majorEnd - majorTickLength
        
        var moveTicks = (bounds.width)/8
        
        
        for i in 0 ... 7{
            if i != 7{
            ctx.move(to: CGPoint(x: moveTicks, y: majorStart))
            ctx.addLine(to: CGPoint(x: moveTicks, y: majorEnd))
            ctx.drawPath(using: .stroke)
                moveTicks += ((bounds.width)/8)
                print(moveTicks)
                print(bounds.width)
            }
        }
    }

    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        drawTicks(in: rect, context: ctx)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height/3.5)
        trackLayer.setNeedsDisplay()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)

        // Hit test the thumb layers
        if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted  = true
        }

        return upperThumbLayer.highlighted
    }
    
    override func cancelTracking(with event: UIEvent?) {
        delegate?.valueChanged(currentStep)
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
//        self.delegate?.valueChanged(currentStep)
    }

    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        
        let location = touch.location(in: self)

        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)

        previousLocation = location

        // 2. Update the values
        if upperThumbLayer.highlighted {
            upperValueTemp += deltaValue
            
        let truncateValue = String(format: "%.3f", upperValueTemp)

            upperValueTemp = boundValue(value: upperValueTemp, toLowerValue: lowerValue, upperValue: maximumValue)
            
            let upperRange = currentStep * 125
            let lowerRange = upperRange - 125

            let truncateUpperValue = Double(truncateValue)
            let multi = Int(truncateUpperValue! * 1000)
            if multi > upperRange &&  currentStep < 8 {
                currentStep += 1
               
            }
            else if multi < lowerRange && currentStep >= 1{
              
                currentStep -= 1
              
            }


          
//            print(multi)
        }
        
//        sendActions(for: .valueChanged)

        
        return true
    }


}

