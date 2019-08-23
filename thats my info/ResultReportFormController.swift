//
//  ResultReportFormController.swift
//  thats my info
//
//  Created by Cory Kim on 23/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit
import LBTATools

extension ResultReportFormController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        //        registrationViewModel.image = image
        firstImageButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

class ResultReportFormController: UIViewController {
    
    fileprivate let resultDataDictionary: Dictionary<String, AnyObject>
    fileprivate let userInfoDict: Dictionary<String, AnyObject>
    fileprivate let currentUrl: String
    
    let customBackNavBar = CustomDismissNavBar(title: "신고", backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1), tintColor: .white)
    let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1))
    
    let nameLabel = UILabel(text: "이 름", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 1)
    let phoneLabel = UILabel(text: "연락처", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 1)
    let urlLabel = UILabel(text: "URL", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 1)
    let contentLabel = UILabel(text: "내용", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .center, numberOfLines: 1)
    
    let nameTextField = UITextField(backgroundColor: .init(white: 0.8, alpha: 0.4))
    let phoneTextField = UITextField(backgroundColor: .init(white: 0.8, alpha: 0.4))
    let urlTextField = UITextField(backgroundColor: .init(white: 0.8, alpha: 0.4))
    let contentTextField = UITextField(backgroundColor: .init(white: 0.8, alpha: 0.4))
    
    let sendButton = UIButton(title: "전송", titleColor: .white, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1), target: self, action: #selector(handleSend))
    
    @objc fileprivate func handleSend() {
        let alert = UIAlertController(title: "전송", message: "신고를 전송하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "확인", style: .default, handler: handleToReport)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func handleToReport(alert: UIAlertAction) {
        dismiss(animated: true, completion: nil)
    }
    
    let firstImageButton: UIButton = {
        let button = UIButton(title: "+", titleColor: .darkGray, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: .init(white: 0.7, alpha: 1), target: self, action: #selector(handleImagePicker))
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.imageView?.contentMode = .scaleAspectFill
        
        button.clipsToBounds = true
        return button
    }()
    
    func generateSquareButton() -> UIButton {
        let button = UIButton(title: "+", titleColor: .darkGray, font: .systemFont(ofSize: 18, weight: .bold), backgroundColor: .init(white: 0.7, alpha: 1), target: self, action: #selector(handleImagePicker))
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }
    
    @objc fileprivate func handleImagePicker(button: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }

    init(userInfoDict: Dictionary<String, AnyObject>, resultDataDictionary: Dictionary<String, AnyObject>, currentUrl: String) {
        self.resultDataDictionary = resultDataDictionary
        self.userInfoDict = userInfoDict
        self.currentUrl = currentUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCustomBehavior()
        setupUI()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    
    fileprivate func setupCustomBehavior() {
        customBackNavBar.dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(customBackNavBar)
        customBackNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        nameLabel.constrainWidth(72)
        phoneLabel.constrainWidth(72)
        let sv1 = UIStackView(arrangedSubviews: [nameLabel, nameTextField, phoneLabel, phoneTextField])
        sv1.axis = .horizontal
        sv1.spacing = 8
        sv1.distribution = .fillProportionally
        view.addSubview(sv1)
        sv1.anchor(top: customBackNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 4, bottom: 0, right: 4), size: .init(width: 0, height: 44))
        nameTextField.text = userInfoDict["name"] as! String
        phoneTextField.text = userInfoDict["phone"] as! String
        
        urlLabel.constrainWidth(64)
        let sv2 = UIStackView(arrangedSubviews: [urlLabel, urlTextField])
        sv2.axis = .horizontal
        sv2.spacing = 8
        sv2.distribution = .fillProportionally
        view.addSubview(sv2)
        sv2.anchor(top: sv1.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 4, bottom: 0, right: 4), size: .init(width: 0, height: 44))
        urlTextField.text = currentUrl
        
        view.addSubview(contentLabel)
        contentLabel.anchor(top: sv2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        view.addSubview(contentTextField)
        contentTextField.anchor(top: contentLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 320))
        
        view.addSubview(sendButton)
        sendButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: 0, height: 64))
        
        let photoLabel = UILabel(text: "사진 첨부", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .left, numberOfLines: 1)
        view.addSubview(photoLabel)
        photoLabel.anchor(top: contentTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
        
        let sv3 = UIStackView(arrangedSubviews: [firstImageButton, generateSquareButton(), generateSquareButton(), generateSquareButton()])
        sv3.axis = .horizontal
        sv3.spacing = 8
        sv3.distribution = .fillEqually
        view.addSubview(sv3)
        sv3.anchor(top: photoLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 88))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
