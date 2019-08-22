//
//  HomeController.swift
//  thats my info
//
//  Created by Cory Kim on 13/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import LBTATools

class HomeController: UIViewController {
    
    let titlelabel = UILabel(text: "님아 그것은 내 정보", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .center)
    
    let detectButtonValue: CGFloat = 240
    let subbuttonsHeightValue: CGFloat = 48
    let themeColor: UIColor = #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1)
    
    let detectDiscriptionLabel1 = UILabel(text: "지금 웹상에 노출되어있는", font: .systemFont(ofSize: 18, weight: .bold), textColor: .lightGray, textAlignment: .center, numberOfLines: 1)
    let detectDiscriptionLabel2 = UILabel(text: "내 개인정보를 확인하세요", font: .systemFont(ofSize: 18, weight: .bold), textColor: .lightGray, textAlignment: .center, numberOfLines: 1)
    
    lazy var detectButton: UIButton = {
        let button = UIButton(title: "", titleColor: themeColor, font: .systemFont(ofSize: 24, weight: .bold), backgroundColor: .white, target: self, action: #selector(handleToDetect))
        button.constrainWidth(detectButtonValue)
        button.constrainHeight(detectButtonValue)
        button.layer.cornerRadius = detectButtonValue / 2
        button.setupShadow(opacity: 0.3, radius: 20, offset: .init(width: 2, height: 16), color: .lightGray)
        return button
    }()
    
    lazy var detectButtonLabel = UILabel(text: "DETECT", font: .systemFont(ofSize: 28, weight: .bold), textColor: themeColor, textAlignment: .center, numberOfLines: 2)
    
    lazy var toInfoButton: UIButton = {
        let button = UIButton(title: "개인정보 관련지식", titleColor: .white, font: .systemFont(ofSize: 16, weight: .medium) ,backgroundColor: themeColor, target: self, action: #selector(handleToInfo))
        button.layer.cornerRadius = 16
        button.constrainHeight(subbuttonsHeightValue)
        button.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 0, height: 3), color: .lightGray)
        return button
    }()
    
    lazy var toReportButton: UIButton = {
        let button = UIButton(title: "개인정보 불법 신고", titleColor: .white, font: .systemFont(ofSize: 16, weight: .medium), backgroundColor: themeColor, target: self, action: #selector(handleToReport))
        button.layer.cornerRadius = 16
        button.constrainHeight(subbuttonsHeightValue)
        button.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 0, height: 3), color: .lightGray)
        return button
    }()
    
    @objc fileprivate func handleToDetect() {
        let detectAuthController = DetectAuthController()
        navigationController?.pushViewController(detectAuthController, animated: true)
    }
    
    @objc fileprivate func handleToReport() {
        let controller = ReportController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc fileprivate func handleToInfo() {
        let infoListController = InfoListController()
        navigationController?.pushViewController(infoListController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigation()
        setupUI()
    }
    
    fileprivate func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }

    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
//        view.addSubview(homeStackView)
//        homeStackView.centerInSuperview()
        view.addSubview(detectButton)
        detectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
        
        view.addSubview(detectDiscriptionLabel2)
        detectDiscriptionLabel2.anchor(top: nil, leading: view.leadingAnchor, bottom: detectButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 48, right: 0))
        view.addSubview(detectDiscriptionLabel1)
        detectDiscriptionLabel1.anchor(top: nil, leading: view.leadingAnchor, bottom: detectDiscriptionLabel2.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
        
        detectButton.addSubview(detectButtonLabel)
        detectButtonLabel.fillSuperview()
        
        view.addSubview(toInfoButton)
        toInfoButton.anchor(top: detectButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 56, left: 64, bottom: 0, right: 64))
        view.addSubview(toReportButton)
        toReportButton.anchor(top: toInfoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 64, bottom: 0, right: 64))
    }
}
