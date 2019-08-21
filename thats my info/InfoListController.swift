//
//  KnowledgeController.swift
//  thats my info
//
//  Created by Cory Kim on 14/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools
import Alamofire

struct InfoCategory {
    let title: String
    let url: String
}

class InfoCell: LBTAListCell<InfoCategory> {
    
    var infoDictsArray: [Dictionary<String, AnyObject>] = []
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    var titleContainer: UIView = {
        let view = UIView(backgroundColor: .red)
        view.layer.cornerRadius = 16
        return view
    }()
    
    var infoLabel = UILabel(text: "0", font: .systemFont(ofSize: 18, weight: .bold), textColor: .darkGray, textAlignment: .left)
    
    override var item: InfoCategory! {
        didSet {
            titleLabel.text = item.title
            
            let requestURL = "https://rs-privacy.azurewebsites.net/info\(item.url)"
            Alamofire.request(requestURL).responseJSON(completionHandler: { (response) in
                let result = response.result
                
                if let array = result.value as? [AnyObject] {
                    array.forEach({ (value) in
                        if let dict = value as? Dictionary<String, AnyObject> {
                            self.infoDictsArray.append(dict)
                        }
                    })
                } else if let dict = result.value as? Dictionary<String, AnyObject> {
                    guard self.infoDictsArray.isEmpty else { return }
                    self.infoDictsArray.append(dict)
                }
                print(self.item.url, self.infoDictsArray.count)
                self.infoLabel.text = "\(self.item.url), \(self.infoDictsArray.count)"
            })
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        
        addSubview(titleContainer)
        titleContainer.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 88))
        
        titleContainer.addSubview(infoLabel)
        infoLabel.centerInSuperview()
    }
}

class InfoListController: LBTAListController<InfoCell, InfoCategory>, UICollectionViewDelegateFlowLayout {
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    fileprivate lazy var infoNavBar = DocumentNavBar()
    fileprivate let navBarHeight: CGFloat = 56
    fileprivate let cellHeight: CGFloat = 96

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            .init(title: "개인정보란?", url: "/privacy-is"),
            .init(title: "개인정보 보호 관련 법제", url: "/rules"),
            .init(title: "개인정보 보호 이용수칙", url: "/rules-of-use"),
            .init(title: "내 정보 지킴이 캠페인", url: "/campaign")
        ]
        
//        fetchDatas()
        setupUI()
        // bug
//        setupTapGesture()
        infoNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
    }
    
    fileprivate func fetchDatas() {
        
        items.forEach { (item) in
            let requestURL = "https://rs-privacy.azurewebsites.net/info\(item.url)"
            
            Alamofire.request(requestURL).responseJSON(completionHandler: { (response) in
                var infoDictsArray: [Dictionary<String, AnyObject>] = []
                let result = response.result
//                print(result.value)
                
                if let array = result.value as? [AnyObject] {
                    array.forEach({ (value) in
                        if let dict = value as? Dictionary<String, AnyObject> {
                            infoDictsArray.append(dict)
                            print(item.title, infoDictsArray.count)
                        }
                    })
                } else if let dict = result.value as? Dictionary<String, AnyObject> {
                    infoDictsArray.append(dict)
//                    print(infoDictsArray)
                    print(item.title, infoDictsArray.count)
                }
            })
        }
    }
    
    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true) // dismisses keyboard
    }
    
    @objc fileprivate func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
//        collectionView.alwaysBounceVertical = true
//        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = navBarHeight + 16
        
        collectionView.addSubview(infoNavBar)
        collectionView.addSubview(topToSafeAreaView)
        
        infoNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedSizeCell = InfoCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 400))
        
        estimatedSizeCell.item = self.items[indexPath.item]
        
        estimatedSizeCell.layoutIfNeeded()
        
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 400))
        
        return .init(width: view.frame.width, height: estimatedSize.height)
        
//        return .init(width: collectionView.frame.width, height: cellHeight)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let infoCategory = items[indexPath.item]
//        let vc = UIViewController()
//        vc.view.backgroundColor = .red
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
