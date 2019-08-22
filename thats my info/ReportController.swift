//
//  ReportController.swift
//  thats my info
//
//  Created by Cory Kim on 15/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class ReportController: UIViewController {
    
    let leftRightPaddingValue: CGFloat = 24
    
    let titlelabel = UILabel(text: "개인정보 불법 신고", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .center)
    let backButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), tintColor: .darkGray)
    let call118Button: UIButton = {
        let button = UIButton(title: "", titleColor: .white, font: .systemFont(ofSize: 18), backgroundColor: .white, target: self, action: #selector(handleCall118))
        button.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 2, height: 2), color: .gray)
        button.layer.cornerRadius = 16
        return button
    }()
    
    let nameLabel = UILabel(text: "개인정보침해 신고센터", font: .systemFont(ofSize: 22, weight: .bold), textColor: .darkGray, textAlignment: .left, numberOfLines: 1)
    let discriptionLabel = UILabel(text: "전화 상담 및 원격점검 등을 통해\nPC 악성코드 감염 예방 및 침해사고 피해\n복구를 지원합니다.", font: .systemFont(ofSize: 16, weight: .medium), textColor: .gray, textAlignment: .left, numberOfLines: 3)
    let timeLabel = UILabel(text: "운영시간 : 연중무휴, 24시간", font: .systemFont(ofSize: 16, weight: .heavy), textColor: .darkGray, textAlignment: .left)
    let callLabel = UILabel(text: "탭하여 전화걸기 (국번없이 118)", font: .systemFont(ofSize: 16, weight: .bold), textColor: #colorLiteral(red: 0.2, green: 0.7294117647, blue: 0.4039215686, alpha: 1), textAlignment: .left)
    let telelPhoneImageView = UIImageView(image: #imageLiteral(resourceName: "telephone").withRenderingMode(.alwaysOriginal), contentMode: .scaleAspectFill)
    
    let manualReportTitleLabel = UILabel(text: "직접 신고하기", font: .systemFont(ofSize: 22, weight: .heavy), textColor: .darkGray, textAlignment: .left, numberOfLines: 1)
    
    let reportStackView = ReportStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setuptButtonsTarget()
    }
    
    fileprivate func setuptButtonsTarget() {
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        [
            reportStackView.infringementButton,
            reportStackView.feudButton,
            reportStackView.leakButton,
            reportStackView.collectionButton
        ].forEach({ $0.addTarget(self, action: #selector(handleToReportWeb), for: .touchUpInside)})
    }
    
    @objc fileprivate func handleToReportWeb(button: UIButton) {
        var webViewController: WebViewController
        switch button {
        case reportStackView.infringementButton:
            webViewController = WebViewController(url: "https://www.privacy.go.kr/wcp/inv/perinfo.do", title: "개인정보 침해신고")
        case reportStackView.feudButton:
            webViewController = WebViewController(url: "https://www.i-privacy.kr/jsp/user4/report/trouble2.jsp", title: "개인정보 분쟁신고")
        case reportStackView.leakButton:
            webViewController = WebViewController(url: "https://www.i-privacy.kr/jsp/user4/report/leack2.jsp", title: "개인정보 유출신고")
        default:
            webViewController = WebViewController(url: "https://www.i-privacy.kr/jsp/user4/report/collect.jsp", title: "개인정보 수집신고")
        }
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc fileprivate func handleCall118() {
        let numberOf118: String = "118"
        guard let number = URL(string: "tel://\(numberOf118)") else { return }
        UIApplication.shared.open(number)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }

    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titlelabel)
        view.addSubview(backButton)
        titlelabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 0))
        
        view.addSubview(call118Button)
        call118Button.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 96, left: leftRightPaddingValue, bottom: 0, right: leftRightPaddingValue), size: .init(width: 0, height: 216))
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 16, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        call118Button.addSubview(nameLabel)
        nameLabel.anchor(top: call118Button.topAnchor, leading: call118Button.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 22, left: 24, bottom: 0, right: 0))
        call118Button.addSubview(discriptionLabel)
        discriptionLabel.anchor(top: nameLabel.bottomAnchor, leading: call118Button.leadingAnchor, bottom: nil, trailing: call118Button.trailingAnchor, padding: .init(top: 8, left: 24, bottom: 0, right: 22))
        call118Button.addSubview(telelPhoneImageView)
        telelPhoneImageView.anchor(top: nil, leading: call118Button.leadingAnchor, bottom: call118Button.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 24, bottom: 20, right: 0), size: .init(width: 44, height: 44))
        
        call118Button.addSubview(callLabel)
        callLabel.anchor(top: nil, leading: telelPhoneImageView.trailingAnchor, bottom: call118Button.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 22, bottom: 20, right: 0))
        call118Button.addSubview(timeLabel)
        timeLabel.anchor(top: nil, leading: telelPhoneImageView.trailingAnchor, bottom: callLabel.topAnchor, trailing: nil, padding: .init(top: 0, left: 22, bottom: 4, right: 0))
        
        view.addSubview(manualReportTitleLabel)
        manualReportTitleLabel.anchor(top: call118Button.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 28, bottom: 0, right: 0))
        view.addSubview(reportStackView)
        reportStackView.anchor(top: manualReportTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: leftRightPaddingValue, bottom: 0, right: leftRightPaddingValue), size: .init(width: 0, height: 256))
    }
}
