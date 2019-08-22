//
//  DetectResultController.swift
//  thats my info
//
//  Created by Cory Kim on 19/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools
import Alamofire
import JGProgressHUD

struct Result {
    let resultDataDictionary: Dictionary<String, AnyObject>
}

class DetectResultController: LBTAListController<DetectResultCell, Result>, UICollectionViewDelegateFlowLayout {
    
    fileprivate let resultHeaderHeight: CGFloat = 200
    fileprivate let navBarHeight: CGFloat = 48
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    fileprivate let headerId = "headerId"
    fileprivate let coverView = UIView(backgroundColor: .white)
    
    fileprivate let navBar = CustomDismissNavBar(title: "탐색 결과")
    
    fileprivate var userInfo: UserInfo
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewSettings()
        setupUI()
        setupNavBarBehavior()
        detect()
        
        // create my CADisplayLink here
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    fileprivate func setupNavBarBehavior() {
        navBar.dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    @objc fileprivate func handleDismiss() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func setupCollectionViewSettings() {
        collectionView.register(ResultHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: resultHeaderHeight)
    }
    
    fileprivate var headerView: ResultHeaderView?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? ResultHeaderView
        setupHeader(headerView!)
        return headerView!
    }
    
    override func setupHeader(_ header: UICollectionReusableView) {
        headerView?.countingStartButton.addTarget(self, action: #selector(handleStartC), for: .touchUpInside)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = -1
    }
    
    @objc fileprivate func handleStartC() {
        animationStartDate = Date()
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedSizeCell = DetectResultCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        estimatedSizeCell.item = self.items[indexPath.item]
        
        estimatedSizeCell.layoutIfNeeded()
        
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
//        print(indexPath.item, estimatedSize)
        return .init(width: view.frame.width, height: estimatedSize.height)
//        return .init(width: view.frame.width, height: 64)
    }
    
    // counting animation label
    var startValue: Double = 0
    var endValue: Double = 0
    let animationDuration: Double = 2.45
    
    var animationStartDate = Date()
    
    @objc fileprivate func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.headerView?.numberOfExposureLabel.text = "\(Int(endValue))"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            
            self.headerView?.numberOfExposureLabel.text = "\(Int(value))"
        }
    }
    
    let detectLoadingHud = JGProgressHUD(style: .dark)
    
    fileprivate func detect() {
        detectLoadingHud.textLabel.text = "탐색중"
        detectLoadingHud.show(in: collectionView, animated: true)
        detectLoadingHud.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let requestURL = "https://rs-privacy.azurewebsites.net/search"
        let parameters = [
            "naverId": userInfo.naverId,
            "phone": userInfo.phone,
            "accessToken": userInfo.accessToken
        ]
        
//        print(parameters)
        
//        var resultDictionaryArray: [Dictionary<String, AnyObject>] = []
        
        Alamofire.request(requestURL, method: .get, parameters: parameters).responseJSON { (response) in
            let result = response.result
            
            if let array = result.value as? [AnyObject] {
                array.forEach({ (value) in
                    if let dict = value as? Dictionary<String, AnyObject> {
//                        resultDictionaryArray.append(dict)
                        guard dict["numOfContents"] as! Int != 0 else { return }
                        self.endValue += dict["numOfContents"] as! Double
                        self.items.append(.init(resultDataDictionary: dict))
//                        print(dict)
                    }
                })
            }
            
            // Detect complete!!
            self.detectLoadingHud.dismiss()
            self.coverView.isHidden = true
            self.startCountingAnimation()
        }
    }
    
    fileprivate func startCountingAnimation() {
        animationStartDate = Date()
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    fileprivate func setupUI() {
        collectionView.scrollIndicatorInsets.top = resultHeaderHeight
        collectionView.contentInset.top = navBarHeight
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        collectionView.addSubview(topToSafeAreaView)
        collectionView.addSubview(navBar)
        navBar.anchor(top: topToSafeAreaView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        collectionView.addSubview(coverView)
        coverView.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
