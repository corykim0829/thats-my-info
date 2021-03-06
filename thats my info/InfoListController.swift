//
//  KnowledgeController.swift
//  thats my info
//
//  Created by Cory Kim on 14/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools
import Alamofire

struct InfoTitleUrl {
    let title: String
    let url: String
}

class InfoListController: LBTAListController<InfoCell, InfoPost>, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1))
    
    fileprivate let infoNavBar = DocumentNavBar()
    fileprivate let navBarHeight: CGFloat = 56
    fileprivate let cellHeight: CGFloat = 96

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchDatas()
        setupNavBarBehaviors()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == infoNavBar.searchField {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    fileprivate func setupNavBarBehaviors() {
        infoNavBar.searchField.delegate = self
        infoNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        infoNavBar.searchField.addTarget(self, action: #selector(handleTextEnd), for: .editingDidEnd)
    }
    
    @objc fileprivate func handleTextEnd(textField: UITextField) {
        let cachedItems = items
        items = []
        
        let keyword: String = textField.text ?? ""
        if keyword == "" {
            items = []
            fetchDatas()
        } else {
            items = cachedItems.filter({ $0.title.contains(keyword) })
        }
    }
    
    fileprivate func fetchDatas() {
        let infoDatas: [InfoTitleUrl] = [
            InfoTitleUrl(title: "개인정보란?", url: "/privacy-is"),
            InfoTitleUrl(title: "개인정보 보호 관련 법제", url: "/rules"),
            InfoTitleUrl(title: "개인정보 보호 이용수칙", url: "/rules-of-use"),
            InfoTitleUrl(title: "내 정보 지킴이 캠페인", url: "/campaign")
        ]
        
        infoDatas.forEach { (infoTitleUrl) in
            
            var infoDictsArray: [Dictionary<String, AnyObject>] = []
            
            let requestURL = "https://rs-privacy.azurewebsites.net/info\(infoTitleUrl.url)"
            Alamofire.request(requestURL).responseJSON(completionHandler: { (response) in
                let result = response.result
                
                if let array = result.value as? [AnyObject] {
                    array.forEach({ (value) in
                        if let dict = value as? Dictionary<String, AnyObject> {
                            infoDictsArray.append(dict)
                            self.items.append(.init(title: dict["title"] as? String ?? "", url: infoTitleUrl.url, infoPostDataDict: dict))
                        }
                    })
                } else if let dict = result.value as? Dictionary<String, AnyObject> {
                    guard infoDictsArray.isEmpty else { return }
                    infoDictsArray.append(dict)
                    self.items.append(.init(title: infoTitleUrl.title, url: infoTitleUrl.url, infoPostDataDict: dict))
                }
            })
        }
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = navBarHeight + 8
        
        collectionView.addSubview(infoNavBar)
        collectionView.addSubview(topToSafeAreaView)
        
        infoNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 56)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infoPost = items[indexPath.item]
        let infoPostController = InfoPostController(infoPost: infoPost)
        navigationController?.pushViewController(infoPostController, animated: true)
    }
}
