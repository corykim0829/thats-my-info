//
//  DetectNaverAuthController.swift
//  thats my info
//
//  Created by Cory Kim on 18/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class DetectNaverAuthController: UIViewController {

    let naverAuthButton = UIButton(title: "NAVER AUTH", titleColor: .white, font: .systemFont(ofSize: 24, weight: .medium), backgroundColor: .clear, target: self, action: #selector(handleNaverAuth))
    
    @objc fileprivate func handleNaverAuth() {
        let naverAuthController = NaverAuthController()
        present(naverAuthController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(naverAuthButton)
        naverAuthButton.centerInSuperview()
    }
}
