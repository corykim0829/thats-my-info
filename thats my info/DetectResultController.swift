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
    
    fileprivate let resultHeaderHeight: CGFloat = 208
    fileprivate let navBarHeight: CGFloat = 48
    fileprivate let headerId = "headerId"
    fileprivate let coverView = UIView(backgroundColor: .white)
    
    fileprivate let topToSafeAreaView = UIView(backgroundColor: .white)
    fileprivate let navBar = CustomDismissNavBar(title: "탐색 결과", backgroundColor: .white, tintColor: .darkGray)
    
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
        setupResultCellBehaviors()
    }
    
    fileprivate func setupResultCellBehaviors() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startCountingAnimation()
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
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        view.layer.zPosition = -1
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let result = items[indexPath.item]
//        let detectResultActionController = DetectResultActionController(resultDataDictionary: result.resultDataDictionary)
//        navigationController?.pushViewController(detectResultActionController, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedSizeCell = DetectResultCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        
        estimatedSizeCell.item = self.items[indexPath.item]
        
        estimatedSizeCell.layoutIfNeeded()
        
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    // counting animation label
    var startValue: Double = 0
    var endValue: Double = 0
    let animationDuration: Double = 2
    
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
    
    let detectLoadingHud = JGProgressHUD(style: .light)
    
    fileprivate var userInfoDict: Dictionary<String, AnyObject> = [:]
    
    fileprivate func detect() {
        detectLoadingHud.textLabel.text = "탐색중"
        detectLoadingHud.show(in: collectionView, animated: true)
        detectLoadingHud.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let requestURL = "https://rs-privacy.azurewebsites.net/search2"
        let parameters = [
            "naverId": userInfo.naverId,
            "phone": userInfo.phone,
            "accessToken": userInfo.accessToken
        ]
        
        Alamofire.request(requestURL, method: .get, parameters: parameters).responseJSON { (response) in
            let result = response.result
            print(result)
            
            if let resultDict = result.value as? Dictionary<String, AnyObject> {
                self.userInfoDict = resultDict["person"] as? Dictionary<String, AnyObject> ?? [:]
                
                if let resultArray = resultDict["results"] as? [AnyObject] {
                    resultArray.forEach({ (value) in
                        if let dict = value as? Dictionary<String, AnyObject> {
                            guard dict["numOfContents"] as! Int != 0 else { return }
                            self.endValue += dict["numOfContents"] as! Double
                            self.items.append(.init(resultDataDictionary: dict))
                        }
                    })
                }
            }
            
//            if let array = result.value as? [AnyObject] {
//                array.forEach({ (value) in
//                    print(value)
//                    if let dict = value as? Dictionary<String, AnyObject> {
//                        print(dict)
////                        guard dict["numOfContents"] as! Int != 0 else { return }
////                        self.endValue += dict["numOfContents"] as! Double
////                        self.items.append(.init(resultDataDictionary: dict))
//                    }
//                })
//            }
            
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
        collectionView.scrollIndicatorInsets.top = navBarHeight
        collectionView.contentInset.top = navBarHeight
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        collectionView.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        collectionView.addSubview(navBar)
        navBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: navBarHeight))
        
        collectionView.addSubview(coverView)
        coverView.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
