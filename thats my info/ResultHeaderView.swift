//
//  ResultHeaderView.swift
//  thats my info
//
//  Created by Cory Kim on 21/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class ResultHeaderView: UICollectionReusableView {
    
    let defaultFontSize: CGFloat = 20
    
//    fileprivate let textColor: UIColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
    fileprivate let textColor: UIColor = .darkGray
    
    lazy var resultLabel = UILabel(text: "당신의 개인정보로 추측되는\n데이터의 개수", font: .systemFont(ofSize: defaultFontSize, weight: .heavy), textColor: .gray, textAlignment: .center, numberOfLines: 2)
    lazy var numberOfExposureLabel = UILabel(text: "1234", font: .systemFont(ofSize: 58, weight: .heavy), textColor: textColor, textAlignment: .center, numberOfLines: 1)
//    lazy var resultDiscriptionLabel = UILabel(text: "건이 노출됐습니다", font: .systemFont(ofSize: defaultFontSize, weight: .heavy), textColor: textColor, textAlignment: .center)
    
    lazy var actionTipLabel = UILabel(text: "결과창을 탭하여 조치 및 신고를 할 수 있습니다", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        
        addSubview(resultLabel)
        resultLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        addSubview(numberOfExposureLabel)
        numberOfExposureLabel.anchor(top: resultLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
//        addSubview(resultDiscriptionLabel)
//        resultDiscriptionLabel.anchor(top: numberOfExposureLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        
        addSubview(actionTipLabel)
        actionTipLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
