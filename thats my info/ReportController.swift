//
//  ReportController.swift
//  thats my info
//
//  Created by Cory Kim on 15/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class ReportController: UIViewController {
    
    let titlelabel = UILabel(text: "개인정보 불법 신고", font: .systemFont(ofSize: 24, weight: .bold), textColor: .white, textAlignment: .center)
    let backButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal))
    let reportStackView = ReportStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(titlelabel)
        view.addSubview(reportStackView)
        view.addSubview(backButton)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
//        reportStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        reportStackView.centerInSuperview()
        reportStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        reportStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true

        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 16, bottom: 0, right: 0), size: .init(width: 24, height: 24))
    }
}
