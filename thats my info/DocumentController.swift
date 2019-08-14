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
        view.setupShadow(opacity: 0.5, radius: 4, offset: .init(width: 0, height: 0), color: .lightGray)
        return view
    }()
    
    override var item: Document! {
        didSet {
            titleLabel.text = item.title
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(titleContainer)
        titleContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 32, bottom: 8, right: 32))
        
        titleContainer.addSubview(titleLabel)
        titleLabel.centerInSuperview()
    }
}

class DocumentController: LBTAListController<DocumentCell, Document>, UICollectionViewDelegateFlowLayout {
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    
    fileprivate lazy var documentNavBar = DocumentNavBar()
    fileprivate let navBarHeight: CGFloat = 56

    override func viewDidLoad() {
        super.viewDidLoad()

        // items를 서버에서 가져올 코드 필요
        
        items = [
            .init(title: "개인정보란?", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 관련 법제", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보 보호 이용수칙", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "내 정보 지킴이 캠페인", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의"),
            .init(title: "개인정보란?", discription: "정보통신망법에서 정의하는 개인정보란, 생존하는개인의")
        ]
        
        setupUI()
        setupTapGesture()
        documentNavBar.backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
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
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.contentInset.top = navBarHeight + 8
        
        collectionView.addSubview(documentNavBar)
        collectionView.addSubview(topToSafeAreaView)
        
        documentNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
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
