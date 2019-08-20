//
//  CollectionController.swift
//  thats my info
//
//  Created by Cory Kim on 17/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    let indicatorView = UIActivityIndicatorView(style: .gray)
    
    var webView = WKWebView()
    var reportUrl = ""
    
    var reportWebNavBar: CustomBackNavBar
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    init(url: String, title: String) {
        reportWebNavBar = CustomBackNavBar(title: title)
        
        super.init(nibName: nil, bundle: nil)
        reportUrl = url
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        reportWebNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        if let url = URL(string: reportUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicatorView.stopAnimating()
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(reportWebNavBar)
        reportWebNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        view.addSubview(webView)
        webView.anchor(top: reportWebNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(indicatorView)
        indicatorView.centerInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
