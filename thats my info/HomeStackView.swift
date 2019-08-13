//
//  HomeStackView.swift
//  thats my info
//
//  Created by Cory Kim on 13/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import LBTATools

class HomeStackView: UIView {
    
    let detectButtonValue: CGFloat = 256
    let subButtonsValue: CGFloat = 128
    
    fileprivate func createButton(image: UIImage, title: String, titleFontSize: CGFloat, value: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        let label: UILabel
        button.backgroundColor = .white
        button.setupShadow(opacity: 0.3, radius: 32, offset: .init(width: 16, height: 16), color: .gray)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.constrainWidth(value)
        button.constrainHeight(value)
        button.layer.cornerRadius = 24
        
        if value > subButtonsValue {
            button.imageView?.withSize(.init(width: 126, height: 126))
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 32)
            label = UILabel(text: title, font: .systemFont(ofSize: 24, weight: .bold), textColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1), textAlignment: .center, numberOfLines: 1)
            button.addSubview(label)
            label.anchor(top: button.imageView?.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        } else {
            button.imageView?.withSize(.init(width: 56, height: 56))
            label = UILabel(text: title, font: .systemFont(ofSize: 12, weight: .heavy), textColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1), textAlignment: .center, numberOfLines: 1)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
            button.addSubview(label)
            label.anchor(top: button.imageView?.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        }
        return button
    }
    
    lazy var toDetectButton = createButton(image: #imageLiteral(resourceName: "detect@100"), title: "내 개인정보 탐색", titleFontSize: 16, value: detectButtonValue)
    lazy var toReportButton = createButton(image: #imageLiteral(resourceName: "24-hours-phone-service"), title: "개인정보 불법 신고", titleFontSize: 16, value: subButtonsValue)
    lazy var toDocumentButton = createButton(image: #imageLiteral(resourceName: "privacy"), title: "개인정보 관련 지식", titleFontSize: 16, value: subButtonsValue)
    
    lazy var buttonsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            toReportButton,
            toDocumentButton
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 12
        return sv
    }()
    
    lazy var homeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            toDetectButton,
            buttonsStackView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 12
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        
        addSubview(homeStackView)
        homeStackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
