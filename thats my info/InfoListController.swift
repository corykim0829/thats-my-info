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

struct InfoPost {
    let title: String
    let url: String
    var infoPostDataDict: Dictionary<String, AnyObject>?
}

class InfoCell: LBTAListCell<InfoPost> {
    
    var infoDictsArray: [Dictionary<String, AnyObject>] = []
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var containerView: UIView = {
        let view = UIView(backgroundColor: .purple)
        view.layer.cornerRadius = 8
        return view
    }()
    
    override var item: InfoPost! {
        didSet {
            titleLabel.text = item.title
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}

class InfoListController: LBTAListController<InfoCell, InfoPost>, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    fileprivate lazy var infoNavBar = DocumentNavBar()
    fileprivate let navBarHeight: CGFloat = 56
    fileprivate let cellHeight: CGFloat = 96

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavBarBehaviors()
        setupTapGesture()
        fetchDatas()
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
        infoNavBar.searchField.addTarget(self, action: #selector(handleSearch), for: .editingDidEndOnExit)
    }
    
    @objc fileprivate func handleSearch(textField: UITextField) {
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
        
//        let urls = ["/privacy-is", "/rules", "/rules-of-use", "/campaign"]
        
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
        let infoCategory = items[indexPath.item]
        
    }
}
