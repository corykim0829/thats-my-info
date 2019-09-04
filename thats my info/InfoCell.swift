//
//  DocumentCell.swift
//  thats my info
//
//  Created by Cory Kim on 14/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

class InfoCell: LBTAListCell<InfoPost> {
    
    var infoDictsArray: [Dictionary<String, AnyObject>] = []
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var containerView: UIView = {
        let view = UIView(backgroundColor: .purple)
        view.layer.cornerRadius = 16
        view.setupShadow(opacity: 0.3, radius: 6, offset: .init(width: 1, height: 1), color: .gray)
        return view
    }()
    
    override var item: InfoPost! {
        didSet {
            titleLabel.text = item.title
            let category = item.infoPostDataDict["category"] as! String
            switch category {
            case "PRIVACY_IS":
                self.containerView.backgroundColor = #colorLiteral(red: 0.9684513954, green: 0.3513740689, blue: 0.3031639295, alpha: 1)
            case "PRIVACY_RULES_OF_USE":
                self.containerView.backgroundColor = #colorLiteral(red: 0.988819818, green: 0.6654537671, blue: 0.1012271759, alpha: 1)
            case "PRIVACY_RULES":
                self.containerView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7974006738, blue: 0.3821168665, alpha: 1)
            default:
                self.containerView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}
