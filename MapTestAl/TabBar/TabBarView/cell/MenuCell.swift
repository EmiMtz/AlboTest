//
//  MenuCell.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import UIKit

class MenuCell: UITableViewCell, ViewDelegate {
    
    var model: MenuOption? {
        didSet {
            guard let viewModel = model else { return }
            
            self.icon.image = UIImage(named: viewModel.iconName)
            self.menuTitle.text = viewModel.optionTitle
        }
    }
    
    var compactConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var regularConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var largeConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        return icon
    }()
    
    lazy var menuTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.font = Fonts.AvenirMedium.of(size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
//        if selected {
//            self.menuTitle.textColor = .white
//        } else {
//            self.menuTitle.textColor = UIColor(hexaRGB: "737388")
//        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initComponents() {
        self.addComponents()
        self.setAutolayout()
        self.activateCurrentLayout()
    }
    
    func addComponents() {
        self.contentView.addSubview(icon)
        self.contentView.addSubview(menuTitle)
    }
    
    func setAutolayout() {
        self.largeConstraints.append(contentsOf: [
            icon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20),
            
            menuTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            menuTitle.leadingAnchor.constraint(equalTo: self.icon.trailingAnchor, constant: 20)
        ])
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
