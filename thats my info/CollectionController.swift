//
//  CollectionController.swift
//  thats my info
//
//  Created by Cory Kim on 17/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import WebKit

class CollectionController: UIViewController {
    
    var webView = WKWebView()
    
    let collectionNavBar = CollectionNavBar()
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        let collectionReportUrl = "https://www.i-privacy.kr/jsp/user4/report/collect.jsp"
        if let url = URL(string: collectionReportUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(collectionNavBar)
        collectionNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        view.addSubview(webView)
        webView.anchor(top: collectionNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
