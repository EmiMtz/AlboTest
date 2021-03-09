//
//  ButtonCustom.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

@IBDesignable public class ButtonCustom: UIButton {
    
     override public init(frame: CGRect) {
           super.init(frame: frame)
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    @IBInspectable public var backgroundNormalColor: UIColor = UIColor.white {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var backgroundSelectedColor: UIColor = UIColor.globalTintColor() {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var textNormalColor: UIColor = UIColor.black {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var textSelectedColor: UIColor = UIColor.black {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable public var radiusCorner: CGFloat = 0 {
           didSet {
               self.layoutSubviews()
           }
       }
    
    @IBInspectable public var shadow: Bool = true {
           didSet {
               self.layoutSubviews()
           }
       }
       
       @IBInspectable var shadowColor: UIColor = UIColor.lightGray {
           didSet {
               self.layoutSubviews()
           }
       }
       
       @IBInspectable public var shadowRadius: CGFloat = 2 {
           didSet {
               self.layoutSubviews()
           }
       }
       
       @IBInspectable public var shadowOpacity: Float = 100 {
           didSet {
               self.layoutSubviews()
           }
       }
       
       @IBInspectable public var widthShadowOffset: CGFloat = 0 {
           didSet {
               self.layoutSubviews()
           }
       }
       
       @IBInspectable public var heightShadowOffset: CGFloat = 7 {
           didSet {
               self.layoutSubviews()
           }
       }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
              didSet {
                  self.layoutSubviews()
              }
          }
    @IBInspectable public var borderColor: UIColor = UIColor.lightGray {
             didSet {
                 self.layoutSubviews()
             }
         }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.adjustsImageWhenHighlighted = false
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = radiusCorner
        self.clipsToBounds = true
        self.tintColor = UIColor.clear
        
         if shadow {
            let shadow : CustomShadow = CustomShadow(color: self.shadowColor, offset: CGSize(width: self.widthShadowOffset, height: self.heightShadowOffset), opacity: self.shadowOpacity / 100, radius: self.shadowRadius / 2)
            shadow.drawShadowInto(control: self)
         }
         
        
        switch self.state {
        case .normal:
            self.backgroundColor = self.backgroundNormalColor
            self.setTitleColor(self.textNormalColor, for: .normal)
//            self.imageView?.image = self.imageView?.image?.withRenderingMode(.alwaysOriginal)
            self.imageView?.tintColor = self.textNormalColor
            break
        case .selected:
            self.backgroundColor = self.backgroundSelectedColor
            self.setTitleColor(self.textSelectedColor, for: .selected)
//            self.imageView?.image = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.imageView?.tintColor = self.textSelectedColor
            break
        default:
            self.backgroundColor = self.backgroundNormalColor
            self.setTitleColor(self.textNormalColor, for: .normal)
            self.imageView?.tintColor = self.textNormalColor
//            self.imageView?.image = self.imageView?.image?.withRenderingMode(.alwaysOriginal)
            break
        }
        
     }
    
    /// Permite seleccionar el botón y adicionalmente configurar el color correspondiente a la imagen en caso de ser necesario.
    /// - Parameter isSelected: Indica si un botón debe o no seleccionarse
    public func setSelected(_ isSelected: Bool) {
        DispatchQueue.main.async {
            self.isSelected = isSelected
            self.adjustsImageWhenHighlighted = false
            if self.imageView?.image != nil {
                if isSelected {
                    self.imageView?.image = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
                    self.imageView?.tintColor = self.textSelectedColor
                }
                else {
                    self.imageView?.image = self.imageView?.image?.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        
    }
}

public extension UIColor {
    static func globalTintColor()->UIColor {
        
        let window : UIWindow? = UIApplication.shared.delegate?.window ?? nil
        return window?.tintColor ?? UIColor.blue
        
    }
}
