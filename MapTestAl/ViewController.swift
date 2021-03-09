//
//  ViewController.swift
//  MapTestAl
//
//  Created by Emiliano Alfredo Martinez Vazquez on 08/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = AirportRadiusSelectRouter.createModule()
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overCurrentContext
        nav.isNavigationBarHidden = true
        
        self.navigationController?.present(nav, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }


}

