//
//  DetectController.swift
//  thats my info
//
//  Created by Cory Kim on 18/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import JGProgressHUD

class DetectAuthController: UIViewController, NaverAuthControllerDelegate {
    
    let titleLabel = UILabel(text: "상세정보 입력", font: .systemFont(ofSize: 20, weight: .bold), textColor: .white, textAlignment: .center)
    let backButton = UIButton(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), tintColor: .white)
    
    let naverIdLabel = UILabel(text: " 네이버 아이디", font: .systemFont(ofSize: 20, weight: .bold), textColor: .white, textAlignment: .left)
    let naverIdDiscriptionLabel = UILabel(text: " @naver.com을 제외한 ID를 적어주세요", font: .systemFont(ofSize: 16, weight: .light), textColor: .white, textAlignment: .left)
    let naverIdTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.layer.cornerRadius = 8
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.constrainHeight(40)
        return tf
    }()
    
    let phoneLabel = UILabel(text: " 핸드폰 번호", font: .systemFont(ofSize: 20, weight: .bold), textColor: .white, textAlignment: .left)
    let phoneDiscriptionLabel = UILabel(text: " 010-1234-5678 형식으로 적어주세요", font: .systemFont(ofSize: 16, weight: .light), textColor: .white, textAlignment: .left)
    let phoneTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.constrainHeight(40)
        tf.layer.cornerRadius = 8
        tf.keyboardType = .phonePad
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let toNaverAuthButton: UIButton = {
       let button = UIButton(title: "네이버 본인인증", titleColor: .white, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: #colorLiteral(red: 0.1776808647, green: 0.8088077911, blue: 0.4675460188, alpha: 1))
        button.addTarget(self, action: #selector(handleToNaverAuth), for: .touchUpInside)
        button.constrainHeight(48)
        button.layer.cornerRadius = 8
        return button
    }()
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        if textField == naverIdTextField {
            authViewModel.naverId = textField.text
            self.naverIdConfirmImage.isHidden = textField.text?.isEmpty ?? true
        } else {
            authViewModel.phone = textField.text
            self.phoneNumberConfirmImage.isHidden = textField.text?.count ?? 0 < 9
        }
    }
    
    let doDetectButton: UIButton = {
        let button = UIButton(title: "탐색 시작", titleColor: .white, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: .lightGray, target: self, action: #selector(handleDoDetect))
        button.constrainHeight(48)
        button.setTitleColor(.darkGray, for: .disabled)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        return button
    }()
    
    @objc fileprivate func handleDoDetect() {
        
    }
    
    let toProvisionButton = UIButton(title: "개인정보보호 처리 방침", titleColor: .white, font: .systemFont(ofSize: 16, weight: .light), backgroundColor: .clear, target: self, action: #selector(handleToProvision))
    
    @objc fileprivate func handleToProvision() {
        let provisionController = ProvisionController()
        present(provisionController, animated: true, completion: nil)
    }
    
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
        let naverAuthController = NaverAuthController()
        naverAuthController.delegate = self
        present(naverAuthController, animated: true, completion: nil)
    }
    
    lazy var stackView: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [
            naverIdLabel,
            naverIdDiscriptionLabel,
            naverIdTextField,
            phoneLabel,
            phoneTextField,
            toNaverAuthButton,
            doDetectButton
            ])
        
        sv.setCustomSpacing(4, after: naverIdLabel)
        sv.setCustomSpacing(8, after: phoneLabel)
        sv.setCustomSpacing(8, after: naverIdDiscriptionLabel)
        sv.setCustomSpacing(16, after: naverIdTextField)
        sv.setCustomSpacing(22, after: phoneTextField)
        sv.setCustomSpacing(12, after: toNaverAuthButton)
        
        sv.axis = .vertical
        return sv
    }()
    
    fileprivate let authViewModel = AuthViewModel()
    fileprivate let authHUD = JGProgressHUD(style: .light)
    
    func didSuceessNaverAuth(accessToken: String) {
        authViewModel.isNaverAuthSuccess = true
        naverAuthConfirmImage.isHidden = !(authViewModel.isNaverAuthSuccess ?? false)
        toNaverAuthButton.isEnabled = !(authViewModel.isNaverAuthSuccess ?? false)
        authViewModel.accessToken = accessToken
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        [naverIdConfirmImage, naverAuthConfirmImage, phoneNumberConfirmImage].forEach({ $0.isHidden = true })
        setupUI()
        setupBindables()
    }
    
    fileprivate func setupBindables() {
        authViewModel.isFormValid.bind { [unowned self] (isFormValid) in
            guard let isFormValid = isFormValid else { return }
            self.doDetectButton.isEnabled = isFormValid
            self.doDetectButton.backgroundColor = isFormValid ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) : .lightGray
        }
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 18, left: 0, bottom: 0, right: 0))
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 72, bottom: 0, right: 72))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -72).isActive = true
        
        view.addSubview(naverIdConfirmImage)
        naverIdConfirmImage.anchor(top: nil, leading: nil, bottom: nil, trailing: naverIdTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        naverIdConfirmImage.centerYAnchor.constraint(equalTo: naverIdTextField.centerYAnchor).isActive = true
        
        view.addSubview(phoneNumberConfirmImage)
        phoneNumberConfirmImage.anchor(top: nil, leading: nil, bottom: nil, trailing: phoneTextField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        phoneNumberConfirmImage.centerYAnchor.constraint(equalTo: phoneTextField.centerYAnchor).isActive = true
        
        view.addSubview(naverAuthConfirmImage)
        naverAuthConfirmImage.anchor(top: nil, leading: nil, bottom: nil, trailing: toNaverAuthButton.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 20, height: 20))
        naverAuthConfirmImage.centerYAnchor.constraint(equalTo: toNaverAuthButton.centerYAnchor).isActive = true
        
        view.addSubview(backButton)
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 24, bottom: 0, right: 0), size: .init(width: 24, height: 24))
        
        view.addSubview(toProvisionButton)
        toProvisionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 0), size: .init(width: 0, height: 16))
    }
}
