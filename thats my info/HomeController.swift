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
    
    let titlelabel = UILabel(text: "님아 그것은 내 정보", font: .systemFont(ofSize: 24, weight: .bold), textColor: .white, textAlignment: .center)
    
    let homeStackView = HomeStackView()
    
    @objc fileprivate func handleToDetect() {
        let userInfo = UserInfo(naverId: "0", phone: "0", accessToken: "0")
//        let detectAuthController = DetectResultController(userInfo: userInfo)
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
        setupSelectors()
    }
    
    fileprivate func setupSelectors() {
        homeStackView.toDetectButton.addTarget(self, action: #selector(handleToDetect), for: .touchUpInside)
        homeStackView.toReportButton.addTarget(self, action: #selector(handleToReport), for: .touchUpInside)
        homeStackView.toDocumentButton.addTarget(self, action: #selector(handleToInfo), for: .touchUpInside)
    }
    
    fileprivate func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }

    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(titlelabel)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        view.addSubview(homeStackView)
        homeStackView.centerInSuperview()
    }
}
