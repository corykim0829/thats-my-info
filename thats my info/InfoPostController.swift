//
//  InfoPostController.swift
//  thats my info
//
//  Created by Cory Kim on 22/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class InfoPostController: UIViewController {
    
    fileprivate let infoPostNavBar: CustomBackNavBar
    fileprivate let infoPostDataDict: Dictionary<String, AnyObject>
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    fileprivate let categoryLabel = UILabel(text: "", font: .systemFont(ofSize: 18), textColor: .darkGray, textAlignment: .left, numberOfLines: 1)
    fileprivate let contentLabel = UILabel(text: "", font: .systemFont(ofSize: 16), textColor: .darkGray, textAlignment: .left, numberOfLines: 0)
    
    init(infoPost: InfoPost) {
        infoPostNavBar = CustomBackNavBar(title: infoPost.title)
        infoPostDataDict = (infoPost.infoPostDataDict)!
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatas()
        setupNavBarBehavior()
        setupUI()
    }
    
    fileprivate func setupNavBarBehavior() {
        infoPostNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate let categoryDictionary: Dictionary<String, String> = ["PRIVACY_IS": "개인정보",
                                          "PRIVACY_RULES_OF_USE": "개인정보 이용 수칙",
                                          "PRIVACY_RULES": "개인정보 보호 관련 법제",
                                          "CAMPAIGN": "내 정보 지킴이 캠페인"
    ]
    
    fileprivate func fetchDatas() {
        let categoryData = infoPostDataDict["category"] as! String
        categoryLabel.text = "카테고리 : \(categoryDictionary[categoryData]!)"
        contentLabel.text = infoPostDataDict["content"] as? String
    }

    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(infoPostNavBar)
        infoPostNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        view.addSubview(categoryLabel)
        categoryLabel.anchor(top: infoPostNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        
        view.addSubview(contentLabel)
        contentLabel.anchor(top: categoryLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
