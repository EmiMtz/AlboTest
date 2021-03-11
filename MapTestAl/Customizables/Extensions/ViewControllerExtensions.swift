//
//  ViewControllerExtensions.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import Foundation
import UIKit

extension UIViewController {
    func hideIndicator() {
        var vc = self
        if  let activityIndicator = vc.view.subviews.last as? CustomLoader{
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        } else {
            vc = UIApplication.shared.keyWindow!.rootViewController!
            if  let activityIndicator = vc.view.subviews.last as? CustomLoader{
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func showIndicator(onMain: Bool = false){
//        DispatchQueue.main.async {
           //Prevents double loader
           if (self.view.subviews.last as? CustomLoader) == nil{
               let activityIndicator = CustomLoader()
               activityIndicator.configLoader()
               activityIndicator.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
               self.view.addSubview(activityIndicator)
               activityIndicator.startAnimating()
           }
//        }
    }
}
