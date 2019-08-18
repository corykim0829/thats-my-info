//
//  ReportStackView.swift
//  thats my info
//
//  Created by Cory Kim on 15/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import LBTATools

class ReportStackView: UIStackView {
    
    let buttonsWidthHeightValue: CGFloat = 128
    let titleFontSize: CGFloat = 24
    
    fileprivate func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setupShadow(opacity: 0.3, radius: 32, offset: .init(width: 16, height: 16), color: .gray)
        button.setTitle(title, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: titleFontSize, weight: .bold)
        button.layer.cornerRadius = 24
        return button
    }
    
    lazy var infringementButton = createButton(title: "침해")
    lazy var leakButton = createButton(title: "유출")
    lazy var feudButton = createButton(title: "분쟁")
    lazy var collectionButton = createButton(title: "수집")
    lazy var call118Button = createButton(title: "CALL 118")
    
    lazy var buttonsStackView1: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            infringementButton,
            leakButton
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 12
        return sv
    }()
    
    lazy var buttonsStackView2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            feudButton,
            collectionButton
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 12
        return sv
    }()
    
//    lazy var mainStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [
//            buttonsStackView1,
//            buttonsStackView2,
//            call118Button])
//        sv.axis = .vertical
//        sv.distribution = .fill
//        sv.spacing = 12
//        return sv
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        addArrangedSubview(buttonsStackView1)
        addArrangedSubview(buttonsStackView2)
        addArrangedSubview(call118Button)
        
        axis = .vertical
        distribution = .fill
        spacing = 12
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        
        let squareButtons = [infringementButton, leakButton, feudButton, collectionButton]
        squareButtons.forEach({
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
        })
        call118Button.heightAnchor.constraint(greaterThanOrEqualToConstant: 88).isActive = true
        call118Button.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
