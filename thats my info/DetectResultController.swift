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
    var title: String
    var numberOfDetect: Int
    var urls: [String]
}

class DetectResultCell: LBTAListCell<Result> {
    
    override var item: Result! {
        didSet {
            titleLabel.text = item.title
            numberOfDetectLabel.text = "\(item.numberOfDetect)건"
        }
    }
    
    let containerView: UIView = {
        let view = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel = UILabel(text: "네이버", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .left, numberOfLines: 1)
    
    let numberOfDetectLabel = UILabel(text: "2건", font: .systemFont(ofSize: 18, weight: .bold), textColor: .white, textAlignment: .left, numberOfLines: 1)
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: containerView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerView.addSubview(numberOfDetectLabel)
        numberOfDetectLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        numberOfDetectLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
}

class DetectResultController: LBTAListController<DetectResultCell, Result>, UICollectionViewDelegateFlowLayout {
    
    fileprivate let resultHeaderHeight: CGFloat = 128
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.6941176471, blue: 0.9647058824, alpha: 1))
    fileprivate let headerId = "headerId"
    
    fileprivate let numberOfExposureLabel = UILabel(text: "1234", font: .systemFont(ofSize: 24, weight: .bold), textColor: .red, textAlignment: .center, numberOfLines: 1)
    
    fileprivate var userInfo: UserInfo
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            .init(title: "NAVER", numberOfDetect: 15, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "GOOGLE", numberOfDetect: 42, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "DAUM", numberOfDetect: 5, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "NAVER BLOG", numberOfDetect: 2, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "DCInside", numberOfDetect: 0, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "FACEBOOK", numberOfDetect: 2, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "NAVER 지식 IN", numberOfDetect: 4, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "NAVER", numberOfDetect: 15, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "GOOGLE", numberOfDetect: 42, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "DAUM", numberOfDetect: 5, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "NAVER BLOG", numberOfDetect: 2, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "DCInside", numberOfDetect: 0, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "FACEBOOK", numberOfDetect: 2, urls: ["https://www.naver.com", "https://www.naver.com"]),
            .init(title: "NAVER 지식 IN", numberOfDetect: 4, urls: ["https://www.naver.com", "https://www.naver.com"])
        ]
        
        setupCollectionViewSettings()
        setupUI()
        detect()
        
        // create my CADisplayLink here
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    fileprivate func setupCollectionViewSettings() {
        collectionView.register(ResultHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: resultHeaderHeight)
    }
    
    var headerView: ResultHeaderView?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? ResultHeaderView
        setupHeader(headerView!)
        return headerView!
    }
    
    override func setupHeader(_ header: UICollectionReusableView) {
        headerView?.countingStartButton.addTarget(self, action: #selector(handleStartC), for: .touchUpInside)
    }
    
    @objc fileprivate func handleStartC() {
        animationStartDate = Date()
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    // counting animation label
    
    var startValue: Double = 0
    var endValue: Double = 200
    let animationDuration: Double = 1
    
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
    
    fileprivate func detect() {
        let postURL = "https://rs-privacy.azurewebsites.net/search"
        let parameters = [
            "naverId": userInfo.naverId,
            "phone": userInfo.phone,
            "accessToken": userInfo.accessToken
        ]
        
        Alamofire.request(postURL, method: .post, parameters: parameters).responseJSON { (response) in
            print(response)
        }
    }
    
    fileprivate func setupUI() {
        collectionView.scrollIndicatorInsets.top = resultHeaderHeight
        collectionView.addSubview(topToSafeAreaView)
        
//        collectionView.contentInset.top = resultHeaderHeight
        
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
//        collectionView.addSubview(numberOfExposureLabel)
//        numberOfExposureLabel.centerInSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
