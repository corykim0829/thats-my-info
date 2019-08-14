//
//  KnowledgeController.swift
//  thats my info
//
//  Created by Cory Kim on 14/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class DocumentCell: LBTAListCell<Document> {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    var titleContainer: UIView = {
        let view = UIView(backgroundColor: .white)
        view.layer.cornerRadius = 16
        view.setupShadow(opacity: 0.3, radius: 4, offset: .init(width: 2, height: 2), color: .lightGray)
        return view
    }()
    
    override var item: Document! {
        didSet {
            titleLabel.text = item.title
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        
        addSubview(titleContainer)
        titleContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 32, bottom: 8, right: 32))
        
        titleContainer.addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
}

class DocumentController: LBTAListController<DocumentCell, Document>, UICollectionViewDelegateFlowLayout {
    
    fileprivate lazy var customDocumentNavBar = CustomDocumentNavBar()
    fileprivate let navBarHeight: CGFloat = 88

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [
            .init(title: "개인정보란?", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 관련 법제", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 이용수칙", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "내 정보 지킴이 캠페인", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보란?", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 관련 법제", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 이용수칙", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "내 정보 지킴이 캠페인", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보란?", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 관련 법제", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 이용수칙", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "내 정보 지킴이 캠페인", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보란?", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 관련 법제", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 이용수칙", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "내 정보 지킴이 캠페인", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의")
        ]
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1)
        collectionView.contentInset.top = navBarHeight + 8
        
        collectionView.addSubview(customDocumentNavBar)
        let window = UIApplication.shared.keyWindow
        let topToSafeAreaTop: CGFloat = window?.safeAreaInsets.top ?? 0
        
        customDocumentNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight + topToSafeAreaTop))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 88)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIViewController()
        controller.view.backgroundColor = .yellow
        navigationController?.pushViewController(controller, animated: true)
        return
    }
}
