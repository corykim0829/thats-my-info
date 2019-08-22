//
//  DetectResultActionController.swift
//  thats my info
//
//  Created by Cory Kim on 22/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import WebKit
import JGProgressHUD

class DetectResultActionController: UIViewController, WKNavigationDelegate {

    fileprivate let resultDataDictionary: Dictionary<String, AnyObject>
    
    var webView = WKWebView()
    var detectResultActionUrl: String
    let themeColor: UIColor = #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1)
    
    var customBackNavBar: CustomBackNavBar
    
    lazy var topToSafeAreaView = UIView(backgroundColor: themeColor)
    
    fileprivate func createBottomButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(title: title, titleColor: .white, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: themeColor, target: self, action: action)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }
    
    lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            createBottomButton(title: "조치", action: #selector(handleMeasure)),
            createBottomButton(title: "신고", action: #selector(handleReport))
            ])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    @objc fileprivate func handleMeasure() {
        
    }
    
    @objc fileprivate func handleReport() {
        
    }
    
    init(resultDataDictionary: Dictionary<String, AnyObject>) {
        self.resultDataDictionary = resultDataDictionary
        let title = resultDataDictionary["siteName"] as! String
        customBackNavBar = CustomBackNavBar(title: title)
        
        let url = resultDataDictionary["url"] as! String
        detectResultActionUrl = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    let webLoadingHud = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(detectResultActionUrl)
        if let url = URL(string: detectResultActionUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        setupCustomBehavior()
        setupUI()
        
        webLoadingHud.show(in: view, animated: true)
        webLoadingHud.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webLoadingHud.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webLoadingHud.dismiss()
    }
    
    fileprivate func setupCustomBehavior() {
        customBackNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(customBackNavBar)
        customBackNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        view.addSubview(bottomStackView)
        bottomStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 64))
        
        view.addSubview(webView)
        webView.anchor(top: customBackNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: bottomStackView.topAnchor, trailing: view.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
