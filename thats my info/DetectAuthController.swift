//
//  DetectController.swift
//  thats my info
//
//  Created by Cory Kim on 18/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class DetectAuthController: UIViewController {
    
    let tempLabel = UILabel(text: "본인인증 SMS", font: .systemFont(ofSize: 24, weight: .bold), textColor: .white, textAlignment: .center)
    let skipButton = UIButton(title: "SKIP", titleColor: .white, font: .systemFont(ofSize: 16, weight: .medium), backgroundColor: .clear, target: self, action: #selector(handleSkip))
    let dismissButton = UIButton(image: #imageLiteral(resourceName: "dismiss_button_bold").withRenderingMode(.alwaysOriginal), tintColor: .white)
    
    @objc fileprivate func handleSkip() {
        let detectNaverAuthController = DetectNaverAuthController()
        navigationController?.pushViewController(detectNaverAuthController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        setupUI()
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(tempLabel)
        tempLabel.centerInSuperview()
        view.addSubview(skipButton)
        skipButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 24))
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 24, bottom: 0, right: 0), size: .init(width: 24, height: 24))
    }
}
