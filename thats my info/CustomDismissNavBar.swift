//
//  NaverAuthNavBar.swift
//  thats my info
//
//  Created by Cory Kim on 20/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class CustomDismissNavBar: UIView {
    
    let titleLabel = UILabel(text: "title", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .center)
    let dismissButton = UIButton(image: #imageLiteral(resourceName: "dismiss_button_bold").withRenderingMode(.alwaysOriginal), tintColor: .white)
    
    init(title: String, backgroundColor: UIColor, tintColor: UIColor) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        titleLabel.textColor = tintColor
        dismissButton.tintColor = tintColor
        self.backgroundColor = backgroundColor
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(dismissButton)
        dismissButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 24, height: 24))
        dismissButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
