//
//  CollectionNavBar.swift
//  thats my info
//
//  Created by Cory Kim on 17/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class CustomBackNavBar: UIView {
    
    let titleLabel = UILabel(text: "title", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .center)
    let backButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal))
    
    init(title: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(backButton)
        backButton.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        backButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
