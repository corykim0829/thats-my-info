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
    
    let titlelabel = UILabel(text: "님아 그것은 내 정보", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .center)
    
    let detectButtonValue: CGFloat = 240
    let subbuttonsHeightValue: CGFloat = 52
    let themeColor: UIColor = #colorLiteral(red: 0.1333333333, green: 0.5882352941, blue: 0.9647058824, alpha: 1)
    
    let backgroundView: UIView = {
        let view = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6815336045, blue: 0.9647058824, alpha: 1))
        let value: CGFloat = 1000
        view.constrainWidth(value)
        view.constrainHeight(value)
        view.layer.cornerRadius = value / 2
        return view
    }()
    
    fileprivate func createCircle(value: CGFloat, color: UIColor) -> UIView {
        let view = UIView(backgroundColor: color)
        let value: CGFloat = value
        view.constrainWidth(value)
        view.constrainHeight(value)
        view.layer.cornerRadius = value / 2
        return view
    }
    
    let detectDiscriptionLabel1 = UILabel(text: "지금 웹상에 노출되어있는", font: .systemFont(ofSize: 18, weight: .medium), textColor: .white, textAlignment: .center, numberOfLines: 1)
    let detectDiscriptionLabel2 = UILabel(text: "내 개인정보를 확인하세요", font: .systemFont(ofSize: 18, weight: .medium), textColor: .white, textAlignment: .center, numberOfLines: 1)
    
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
        button.layer.cornerRadius = 24
        button.constrainHeight(subbuttonsHeightValue)
        button.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 0, height: 3), color: .lightGray)
        return button
    }()
    
    lazy var toReportButton: UIButton = {
        let button = UIButton(title: "개인정보 불법 신고", titleColor: .white, font: .systemFont(ofSize: 16, weight: .medium), backgroundColor: themeColor, target: self, action: #selector(handleToReport))
        button.layer.cornerRadius = 24
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
        
        view.addSubview(backgroundView)
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        view.addSubview(detectButton)
        detectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -32).isActive = true
        
        view.addSubview(detectDiscriptionLabel2)
        detectDiscriptionLabel2.anchor(top: nil, leading: view.leadingAnchor, bottom: detectButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 48, right: 0))
        view.addSubview(detectDiscriptionLabel1)
        detectDiscriptionLabel1.anchor(top: nil, leading: view.leadingAnchor, bottom: detectDiscriptionLabel2.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
        
        detectButton.addSubview(detectButtonLabel)
        detectButtonLabel.fillSuperview()
        
        let sidePadding: CGFloat = 48
        view.addSubview(toInfoButton)
        toInfoButton.anchor(top: detectButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 80, left: sidePadding, bottom: 0, right: sidePadding))
        view.addSubview(toReportButton)
        toReportButton.anchor(top: toInfoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: sidePadding, bottom: 0, right: sidePadding))
        
        backgroundView.anchor(top: nil, leading: nil, bottom: detectButton.centerYAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: -16, right: 0))
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        [createCircle(value: 950, color: #colorLiteral(red: 0.1333333333, green: 0.580666738, blue: 0.9647058824, alpha: 1)), createCircle(value: 900, color: #colorLiteral(red: 0.1333333333, green: 0.5, blue: 0.9647058824, alpha: 1))].forEach({
            backgroundView.addSubview($0)
            $0.centerInSuperview()
        })
    }
}
