//
//  MenuView.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 10/03/21.
//

import UIKit

protocol MenuViewDelegate: NSObjectProtocol {
    func didSelectItem(_ index: Int)
}

class MenuView: UIView, ViewDelegate {
    
    weak var delegate: MenuViewDelegate?
    
    var compactConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var regularConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    var largeConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    let menuOptions = [
        MenuOption(iconName: "logoutIcon", optionTitle: "Cerrar sesión")
    ]
    
    lazy var overlay: UIView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didOverlayPress))
        tap.numberOfTouchesRequired = 1
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var container: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "menuBackground")
        view.contentMode = .scaleToFill
        view.layer.shadowOffset = CGSize(width: 3.0, height: 0.0)
        view.layer.shadowRadius = 8.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(MenuCell.self, forCellReuseIdentifier: "menu")
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.allowsMultipleSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    lazy var versionLabel: UILabel = {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let label = UILabel(frame: .zero)
        label.text = "Versión " + appVersion
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initComponents() {
        self.addComponents()
        self.setAutolayout()
        self.activateCurrentLayout()
        self.setDelegates()
    }
    
    func addComponents() {
        self.addSubview(overlay)
        self.addSubview(container)
        self.addSubview(table)
        self.addSubview(versionLabel)
    }
    
    func setAutolayout() {
        self.largeConstraints.append(contentsOf:[
            self.overlay.topAnchor.constraint(equalTo: self.topAnchor),
            self.overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.container.topAnchor.constraint(equalTo: self.topAnchor),
            self.container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            self.table.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.table.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.table.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.table.heightAnchor.constraint(equalToConstant: 600),
            
            self.versionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.versionLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.versionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
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
    
    func setDelegates() {
        self.table.delegate = self
        self.table.dataSource = self
    }

}

extension MenuView {
    
    @objc
    private func didOverlayPress() {
        
    }

}

extension MenuView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as? MenuCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = menuOptions[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
}
