//
//  DetectResultCell.swift
//  thats my info
//
//  Created by Cory Kim on 22/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class DetectResultCell: LBTAListCell<Result> {
    
    let containerView: UIView = {
        let view = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1))
        view.layer.cornerRadius = 16
        return view
    }()
    
    let titleFontSize: CGFloat = 18
    
    lazy var titleLabel = UILabel(text: "네이버", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .white, textAlignment: .left, numberOfLines: 1)
    
    lazy var numberOfDetectLabel = UILabel(text: "2건", font: .systemFont(ofSize: titleFontSize, weight: .bold), textColor: .white, textAlignment: .left, numberOfLines: 1)
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.textColor = .clear
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 18)
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    var contents: [String] = []
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    class CustomContentView: UIView {
        
        let contentContainerView: UIView = {
            let view = UIView(backgroundColor: .white)
            view.layer.cornerRadius = 12
            return view
        }()
        
        let contentTextView: UITextView = {
            let tv = UITextView()
            tv.textColor = .darkGray
            tv.backgroundColor = .clear
            tv.font = .systemFont(ofSize: 15)
            tv.isScrollEnabled = false
            tv.isEditable = false
            return tv
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        fileprivate func setupUI() {
            backgroundColor = .clear
            addSubview(contentContainerView)
            contentContainerView.fillSuperview()
            contentContainerView.addSubview(contentTextView)
            contentTextView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override var item: Result! {
        didSet {
            
            titleLabel.text = item.resultDataDictionary["siteName"] as? String
            
            if titleLabel.text?.contains("네이버") ?? false {
                containerView.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.8078431373, blue: 0.4666666667, alpha: 1)
            } else if titleLabel.text?.contains("다음") ?? false {
                containerView.backgroundColor = #colorLiteral(red: 0.9684513954, green: 0.3513740689, blue: 0.3031639295, alpha: 1)
            } else if titleLabel.text?.contains("트위터") ?? false {
                containerView.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
            } else if titleLabel.text?.contains("빙") ?? false {
                containerView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.6666666667, blue: 0.1019607843, alpha: 1)
            } else {
//                let colors = [#colorLiteral(red: 0.988819818, green: 0.6654537671, blue: 0.1012271759, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
//                let randomNumber = arc4random_uniform(2)
//                containerView.backgroundColor = colors[Int(randomNumber)]
                containerView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }
            
            let numberOfContents = item.resultDataDictionary["numOfContents"] as? Int ?? 0
            numberOfDetectLabel.text = "\(numberOfContents)건"
            
            contents = item.resultDataDictionary["contents"] as! [String]
            
            var contentsList: String = ""
            contents.forEach { (_) in
                let twoLinesText = "HELLO\nGOODBYE"
                contentsList += twoLinesText + "\n"
            }
            textView.text = contentsList
            
            stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            contents.forEach { (content) in
                let customContentView = CustomContentView()
                customContentView.contentTextView.text = content
                stackView.addArrangedSubview(customContentView)
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(containerView)
        containerView.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 0, height: -3), color: .gray)
        containerView.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 24, bottom: 0, right: 0))
        
        containerView.addSubview(numberOfDetectLabel)
        numberOfDetectLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 24))
        numberOfDetectLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        containerView.addSubview(textView)
        textView.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
        
        containerView.addSubview(stackView)
        stackView.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
}
