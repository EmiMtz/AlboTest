//
//  FloatingTabBarCell.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

class FloatingTabBarCell: UICollectionViewCell, ViewDelegate {
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                if self.isSelected {
                    self.selectIndicator.isHidden = false
                    self.icon.tintColor = UIColor.gray
                } else {
                    self.selectIndicator.isHidden = true
                    self.icon.tintColor = UIColor(red: 92/255, green: 95/255, blue: 100/255, alpha: 1)
                }
            }
        }
    }
    
    var compactConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var regularConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var largeConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    lazy var selectIndicator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.gray
        view.layer.cornerRadius = 1.5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "dashboardIcon")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 92/255, green: 95/255, blue: 100/255, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initComponents() {
        addComponents()
        setAutolayout()
        activateCurrentLayout()
    }
    
    func addComponents() {
        self.contentView.addSubview(selectIndicator)
        self.contentView.addSubview(icon)
    }
    
    func setAutolayout() {
        largeConstraints = [
            selectIndicator.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            selectIndicator.heightAnchor.constraint(equalToConstant: 3),
            selectIndicator.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            selectIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            icon.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 30)
        ]
    }
    
    func activateCurrentLayout() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                // iPhone 5 or 5S or 5C
                NSLayoutConstraint.activate(compactConstraints)
            case 1334:
                // iPhone 6/6S/7/8
                NSLayoutConstraint.activate(largeConstraints)
            case 2208:
                // iPhone 6+/6s+/7+/8+
                NSLayoutConstraint.activate(largeConstraints)
            case 2436:
                // iPhone X/Xs/11 Pro
                NSLayoutConstraint.activate(largeConstraints)
            case 1792:
                // iPhone 11/XR
                NSLayoutConstraint.activate(largeConstraints)
            default:
                // 11 Pro Max/Xs Max
                NSLayoutConstraint.activate(largeConstraints)
            }
        } else if UIDevice().userInterfaceIdiom == .pad {
            // iPad cases
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
}

