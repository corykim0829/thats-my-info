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
    
    let titleFontSize: CGFloat = 20
    
    fileprivate func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setupShadow(opacity: 0.3, radius: 8, offset: .init(width: 2, height: 2), color: .gray)
        button.setTitleColor(.clear, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: titleFontSize, weight: .bold)
        button.layer.cornerRadius = 24
        return button
    }
    
    lazy var infringementButtonlabel = UILabel(text: "개인정보\n침해신고", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .darkGray, textAlignment: .left, numberOfLines: 2)
    lazy var leakButtonlabel = UILabel(text: "개인정보\n유출신고", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .darkGray, textAlignment: .left, numberOfLines: 2)
    lazy var feudButtonlabel = UILabel(text: "개인정보\n분쟁신고", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .darkGray, textAlignment: .left, numberOfLines: 2)
    lazy var collectionButtonlabel = UILabel(text: "개인정보\n수집신고", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .darkGray, textAlignment: .left, numberOfLines: 2)
    
    lazy var infringementButton = createButton()
    lazy var leakButton = createButton()
    lazy var feudButton = createButton()
    lazy var collectionButton = createButton()
    
    lazy var buttonsStackView1: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            infringementButton,
            leakButton
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        return sv
    }()
    
    lazy var buttonsStackView2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            feudButton,
            collectionButton
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 16
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        addArrangedSubview(buttonsStackView1)
        addArrangedSubview(buttonsStackView2)
        
        axis = .vertical
        distribution = .fillEqually
        spacing = 16
    }
    
    fileprivate func setupUI() {
        backgroundColor = .clear
        
        let leftPaddingValue:CGFloat = 20
        infringementButton.addSubview(infringementButtonlabel)
        infringementButtonlabel.anchor(top: infringementButton.topAnchor, leading: infringementButton.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: leftPaddingValue, bottom: 0, right: 0))
        leakButton.addSubview(leakButtonlabel)
        leakButtonlabel.anchor(top: leakButton.topAnchor, leading: leakButton.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: leftPaddingValue, bottom: 0, right: 0))
        feudButton.addSubview(feudButtonlabel)
        feudButtonlabel.anchor(top: feudButton.topAnchor, leading: feudButton.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: leftPaddingValue, bottom: 0, right: 0))
        collectionButton.addSubview(collectionButtonlabel)
        collectionButtonlabel.anchor(top: collectionButton.topAnchor, leading: collectionButton.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 26, left: leftPaddingValue, bottom: 0, right: 0))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
