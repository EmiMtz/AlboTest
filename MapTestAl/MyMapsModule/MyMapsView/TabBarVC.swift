//
//  TabBarVC.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

class TabBarVC: UITabBarController {
    
    lazy var tabContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 23.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 20.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tabCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FloatingTabBarCell.self, forCellWithReuseIdentifier: "tab")
        collection.backgroundColor = UIColor.white
        collection.layer.cornerRadius = 17.0
        collection.allowsMultipleSelection = false
        collection.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        collection.layer.shadowRadius = 10.0
        collection.layer.shadowColor = UIColor.black.cgColor
        collection.layer.shadowOpacity = 0.3
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    // tabla que se usara para mostrar las opciones
    let iconsName = ["ic_account_locate", "homeIcon"]

    let controllers: [UIViewController]
    
    required init(controllers: [UIViewController]) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupTabBar()
            
        }
        setCollection()
        setDelegates()
        self.tabCollection.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: - Métodos de ciclo de vida del controlador
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {}
    
    override func viewDidDisappear(_ animated: Bool) {}
    
    override func didReceiveMemoryWarning() {
        debugPrint("Problema de memoria")
    }
    
}

extension TabBarVC {
    
    private func setCollection() {
        self.view.addSubview(tabContainer)
        self.view.addSubview(tabCollection)
        
        NSLayoutConstraint.activate([
            tabContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tabContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            tabContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            tabContainer.heightAnchor.constraint(equalToConstant: 69)
        ])
        
        NSLayoutConstraint.activate([
            tabCollection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            tabCollection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            tabCollection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            tabCollection.heightAnchor.constraint(equalToConstant: 69)
        ])
    }
    
    private func setDelegates() {
        self.tabCollection.delegate = self
        self.tabCollection.dataSource = self
    }
    // MARK: - TabBar setup
    
    private func setupTabBar() {
        
        let controllers = self.controllers
        
        self.setViewControllers(controllers, animated: true)
        self.tabBar.barTintColor = UIColor.gray
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.isHidden = true
    }
}

extension TabBarVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return iconsName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tab", for: indexPath) as? FloatingTabBarCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.icon.image = UIImage(named: iconsName[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        
        if indexPath.item == 0 {
            cell.layer.cornerRadius = 17.0
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        
        if indexPath.item == iconsName.count - 1 {
            cell.layer.cornerRadius = 17.0
            cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = self.tabCollection.frame.width/2
        let h = self.tabCollection.frame.height
        
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.item

    }
    
    
}
