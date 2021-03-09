//
//  ProtocolUI.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import Foundation
import UIKit

protocol ViewDelegate {
    var compactConstraints: [NSLayoutConstraint] { get set }
    var regularConstraints: [NSLayoutConstraint] { get set }
    var largeConstraints: [NSLayoutConstraint] { get set }
    
    func initComponents()
    func addComponents()
    func setAutolayout()
    func activateCurrentLayout()
    func setDelegates()
    func setButtonTargets()
}

extension ViewDelegate {
    func setDelegates() {}
    func setButtonTargets() {}
}
