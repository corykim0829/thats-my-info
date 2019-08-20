//
//  ResultHeaderView.swift
//  thats my info
//
//  Created by Cory Kim on 21/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class ResultHeaderView: UICollectionReusableView {
    
    let countingStartButton = UIButton(title: "START", titleColor: .white, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: .red)
    
    let resultLabel = UILabel(text: "현재 당신의 정보는 현재", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .center)
    let numberOfExposureLabel = UILabel(text: "1234", font: .systemFont(ofSize: 36, weight: .heavy), textColor: .white, textAlignment: .center, numberOfLines: 1)
    let resultDiscriptionLabel = UILabel(text: "건의 개인정보가 노출됐습니다.", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .purple
        
        addSubview(resultLabel)
        resultLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        addSubview(numberOfExposureLabel)
        numberOfExposureLabel.anchor(top: resultLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        addSubview(resultDiscriptionLabel)
        resultDiscriptionLabel.anchor(top: numberOfExposureLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        addSubview(countingStartButton)
        countingStartButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0), size: .init(width: 36, height: 36))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
