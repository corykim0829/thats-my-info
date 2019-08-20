//
//  DetectController.swift
//  thats my info
//
//  Created by Cory Kim on 18/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class DetectAuthController: UIViewController {
    
    let titleLabel = UILabel(text: "상세정보 입력", font: .systemFont(ofSize: 20, weight: .bold), textColor: .white, textAlignment: .center)
    let dismissButton = UIButton(image: #imageLiteral(resourceName: "dismiss_button_bold").withRenderingMode(.alwaysOriginal), tintColor: .white)
    
    let naverIdLabel = UILabel(text: " 네이버 아이디", font: .systemFont(ofSize: 20, weight: .bold), textColor: .white, textAlignment: .left)
    let naverIdDiscriptionLabel = UILabel(text: " @naver.com을 제외한 ID를 적어주세요", font: .systemFont(ofSize: 16, weight: .light), textColor: .white, textAlignment: .left)
    let naverIdTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.layer.cornerRadius = 16
        tf.constrainHeight(40)
        return tf
    }()
    
    let phoneLabel = UILabel(text: " 핸드폰 번호", font: .systemFont(ofSize: 20, weight: .bold), textColor: .white, textAlignment: .left)
    let phoneDiscriptionLabel = UILabel(text: " 010-1234-5678 형식으로 적어주세요", font: .systemFont(ofSize: 16, weight: .light), textColor: .white, textAlignment: .left)
    let phoneTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.constrainHeight(40)
        tf.layer.cornerRadius = 16
        tf.keyboardType = .phonePad
        return tf
    }()
    
    let toNaverAuthButton: UIButton = {
       let button = UIButton(title: "네이버 본인인증", titleColor: .white, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: #colorLiteral(red: 0.1776808647, green: 0.8088077911, blue: 0.4675460188, alpha: 1))
        button.addTarget(self, action: #selector(handleToNaverAuth), for: .touchUpInside)
        button.constrainHeight(52)
        button.layer.cornerRadius = 16
        return button
    }()
    
    let naverIdConfirmImage = UIImageView(image: #imageLiteral(resourceName: "confirm").withRenderingMode(.alwaysOriginal), contentMode: .scaleAspectFill)
    let phoneNumberConfirmImage = UIImageView(image: #imageLiteral(resourceName: "confirm").withRenderingMode(.alwaysOriginal), contentMode: .scaleAspectFill)
    let naverAuthConfirmImage: UIImageView = {
        let iv = UIImageView()
        let image = #imageLiteral(resourceName: "confirm").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.white
        iv.image = image
        return iv
    }()
    
    @objc fileprivate func handleToNaverAuth() {
        
    }
    
    lazy var stackView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [
            naverIdLabel,
            naverIdDiscriptionLabel,
            naverIdTextField,
            phoneLabel,
            phoneDiscriptionLabel,
            phoneTextField,
            toNaverAuthButton
            ])
        
        sv.setCustomSpacing(4, after: naverIdLabel)
        sv.setCustomSpacing(4, after: phoneLabel)
        sv.setCustomSpacing(8, after: naverIdDiscriptionLabel)
        sv.setCustomSpacing(8, after: phoneDiscriptionLabel)
        sv.setCustomSpacing(16, after: naverIdTextField)
        sv.setCustomSpacing(24, after: phoneTextField)
        
        sv.axis = .vertical
        return sv
    }()
    
    @objc fileprivate func handleSkip() {
        let detectNaverAuthController = DetectNaverAuthController()
        navigationController?.pushViewController(detectNaverAuthController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        
        setupUI()
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 18, left: 0, bottom: 0, right: 0))
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 72, bottom: 0, right: 72))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        
        view.addSubview(naverIdConfirmImage)
        naverIdConfirmImage.anchor(top: nil, leading: nil, bottom: nil, trailing: naverIdTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        naverIdConfirmImage.centerYAnchor.constraint(equalTo: naverIdTextField.centerYAnchor).isActive = true
        
        view.addSubview(phoneNumberConfirmImage)
        phoneNumberConfirmImage.anchor(top: nil, leading: nil, bottom: nil, trailing: phoneTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        phoneNumberConfirmImage.centerYAnchor.constraint(equalTo: phoneTextField.centerYAnchor).isActive = true
        
        view.addSubview(naverAuthConfirmImage)
        naverAuthConfirmImage.anchor(top: nil, leading: nil, bottom: nil, trailing: toNaverAuthButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        naverAuthConfirmImage.centerYAnchor.constraint(equalTo: toNaverAuthButton.centerYAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 24), size: .init(width: 24, height: 24))
    }
}
