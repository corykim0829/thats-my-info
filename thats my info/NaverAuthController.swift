//
//  NaverAuthController.swift
//  thats my info
//
//  Created by Cory Kim on 19/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

protocol NaverAuthControllerDelegate {
    func didSuceessNaverAuth(accessToken: String)
}

class NaverAuthController: UIViewController, WKNavigationDelegate {
    
    var delegate: NaverAuthControllerDelegate?

    let naverLoginAuthURL = "https://rs-privacy.azurewebsites.net/nvlogin/auth"
    let successURL = "https://rs-privacy.azurewebsites.net/nvlogin/success"
    let indicatorView = UIActivityIndicatorView(style: .gray)
    
    let webView = WKWebView()
    
    var naverAuthNavBar = CustomDismissNavBar(title: "네이버 본인인증")
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        naverAuthNavBar.dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        if let url = URL(string: naverLoginAuthURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void)
    {
        guard let url = navigationAction.request.url else { return }
        let urlPath: String = url.absoluteString.removingPercentEncoding!
        print("*****", urlPath)
        
        let successUrl = urlPath.components(separatedBy: "#").first
//        print("SUCESS", successUrl!)
        
        let token = urlPath.components(separatedBy: "#").last
        
        if successUrl == successURL {
            self.delegate?.didSuceessNaverAuth(accessToken: token ?? "")
            dismiss(animated: true)
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        indicatorView.stopAnimating()
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(naverAuthNavBar)
        naverAuthNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        view.addSubview(webView)
        webView.anchor(top: naverAuthNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(indicatorView)
        indicatorView.centerInSuperview()
    }
}
