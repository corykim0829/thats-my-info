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

class NaverAuthController: UIViewController, WKNavigationDelegate {

    let naverLoginAuthURL = "https://rs-privacy.azurewebsites.net/nvlogin/auth"
    let indicatorView = UIActivityIndicatorView(style: .gray)
    
    let urlLabel = UILabel(text: "now", font: .systemFont(ofSize: 24, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 0)
    
    let webView = WKWebView()
    
    var reportWebNavBar = ReportWebNavBar(title: "네이버 본인인증")
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        reportWebNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
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
        print("***decidePolicyFor navigationAction")
        if let url = navigationAction.request.url {
            let urlPath: String = url.absoluteString.removingPercentEncoding!
            urlLabel.text = urlPath
            print("URL PATH :", urlPath)
            
            Alamofire.request(urlPath).response { response in // method defaults to `.get`
                debugPrint(response)
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("**didReceiveServerRedirectForProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("*didFinish")
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
        
        view.addSubview(urlLabel)
        urlLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 0))
    }
}
