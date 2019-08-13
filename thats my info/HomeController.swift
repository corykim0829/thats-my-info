//
//  HomeController.swift
//  thats my info
//
//  Created by Cory Kim on 13/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setupNavigation()
        setupUI()
    }
    
    fileprivate func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }

    fileprivate func setupUI() {
        
    }
}
