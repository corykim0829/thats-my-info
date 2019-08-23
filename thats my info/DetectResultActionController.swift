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
    fileprivate let userInfoDict: Dictionary<String, AnyObject>
    
    let webView = WKWebView()
    let detectResultActionUrl: String
    let themeColor: UIColor = #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1)
    
    let customBackNavBar: CustomBackNavBar
    
    lazy var topToSafeAreaView = UIView(backgroundColor: themeColor)
    
    init(userInfoDict: Dictionary<String, AnyObject>, resultDataDictionary: Dictionary<String, AnyObject>) {
        self.resultDataDictionary = resultDataDictionary
        self.userInfoDict = userInfoDict
        let title = resultDataDictionary["siteName"] as! String
        customBackNavBar = CustomBackNavBar(title: title)
        
        let url = resultDataDictionary["url"] as! String
        detectResultActionUrl = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
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
        let title = resultDataDictionary["siteName"] as! String
        if title.contains("네이버") {
            print("네이버 조치")
            
            let url = "https://help.naver.com/support/contents/contents.help?serviceNo=964&categoryNo=2826&contentsNo=13342&interactiveMainNo=12600"
            if let url = URL(string: url) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            
        } else {
            let alert = UIAlertController(title: "", message: "아직 준비중입니다", preferredStyle: UIAlertController.Style.alert)
            let defaultAction = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func handleReport() {
        
        let alert = UIAlertController(title: "신고", message: "현재 보고있는 화면이 신고 url로 들어갑니다.\n신고하고자하는 화면으로 이동해주세요", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: handleToReport)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func handleToReport(alert: UIAlertAction) {
        if let currentUrl = webView.url {
            let resultReportFormController = ResultReportFormController(userInfoDict: userInfoDict, resultDataDictionary: resultDataDictionary, currentUrl: currentUrl.absoluteString)
            present(resultReportFormController, animated: true, completion: nil)
        }
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
