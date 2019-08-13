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
        button.backgroundColor = .white
        button.setupShadow(opacity: 0.4, radius: 32, offset: .init(width: 16, height: 16), color: .gray)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        if value > subButtonsValue {
            button.imageView?.withSize(.init(width: 126, height: 126))
        } else {
            button.imageView?.withSize(.init(width: 64, height: 64))
        }
        button.constrainWidth(value)
        button.constrainHeight(value)
        button.layer.cornerRadius = 24
        return button
    }
    
    lazy var toDetectButton = createButton(image: #imageLiteral(resourceName: "detect@100"), title: "내 개인정보 탐색", titleFontSize: 16, value: detectButtonValue)
    lazy var toReportButton = createButton(image: #imageLiteral(resourceName: "report"), title: "개인정보 불법 신고", titleFontSize: 16, value: subButtonsValue)
    lazy var toDocumentButton = createButton(image: #imageLiteral(resourceName: "knowledge"), title: "개인정보 불법 신고", titleFontSize: 16, value: subButtonsValue)
    
    lazy var buttonsStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            toReportButton,
            toDocumentButton
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    lazy var homeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            toDetectButton,
            buttonsStackView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8
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
