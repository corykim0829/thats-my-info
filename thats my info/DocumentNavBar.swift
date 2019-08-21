//
//  CustomDocumentNavBar.swift
//  thats my info
//
//  Created by Cory Kim on 15/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class DocumentNavBar: UIView {
    
    let searchField: UITextField = {
        let tf = CustomTextField(padding: 32)
        tf.backgroundColor = .white
        tf.placeholder = "검색하세요"
        tf.font = .systemFont(ofSize: 16, weight: .bold)
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    fileprivate let searchImage = UIImageView(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal))
    
    fileprivate let titleFontSize: CGFloat = 24
    fileprivate lazy var titleLabel = UILabel(text: "개인정보 관련 지식", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .white, textAlignment: .center, numberOfLines: 1)
    let backButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        addSubview(searchField)
        searchField.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 64, bottom: 10, right: 64))
        
        addSubview(backButton)
        backButton.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        backButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor).isActive = true
        searchField.addSubview(searchImage)
        searchImage.tintColor = .gray
        searchImage.anchor(top: nil, leading: searchField.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 16, height: 16))
        searchImage.centerYAnchor.constraint(equalTo: searchField.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
