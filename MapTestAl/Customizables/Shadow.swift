//
//  Shadow.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

 public class CustomShadow : NSObject {
    
    public var color : UIColor? = UIColor.darkGray
    public var offset : CGSize? = .zero
    public var opacity : Float? = 0.6
    public var radius : CGFloat? = 3.0
    public var cornerRadius : CGFloat? = 0
    
    override public init()
    {
        super .init()
    }
    
    public init(color: UIColor, offset: CGSize, opacity:Float , radius:CGFloat, cornerRadius:CGFloat)
    {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
        self.cornerRadius = cornerRadius
        
    }
    
    public init(color: UIColor, offset: CGSize, opacity:Float , radius:CGFloat)
    {
        self.color = color
        self.offset = offset
        self.opacity = opacity
        self.radius = radius
        
    }
    
    public init(color: UIColor)
    {
        self.color = color
    }
    
    public init(radius:CGFloat){
        self.radius = radius
    }
    
    public init(color: UIColor, radius:CGFloat)
    {
        self.color = color
        self.radius = radius
    }
    
    public func drawShadowInto(control:UIControl){
        self.cornerRadius = control.layer.cornerRadius
        control.layer.setShadowLayer(shadow: self)
    
    }
    
    public func drawShadowInto(view:UIView){
        self.cornerRadius = view.layer.cornerRadius
        view.layer.setShadowLayer(shadow: self)
    }
    
}

extension CALayer {
    
    func setShadowLayer(shadow: CustomShadow){
        self.setShadowLayer(color:  shadow.color?.cgColor, opacity: shadow.opacity, offset: shadow.offset, radius: shadow.radius, cornerRadius: shadow.cornerRadius)
    }
    
    func setShadowLayer(color:CGColor?, opacity:Float?, offset:CGSize?, radius:CGFloat?, cornerRadius:CGFloat?){
        self.shadowColor = color
        self.shadowOpacity = opacity!
        self.shadowOffset = offset!
        self.shadowRadius = radius!
        self.cornerRadius = cornerRadius ?? 0
        self.masksToBounds = false
    }
}
