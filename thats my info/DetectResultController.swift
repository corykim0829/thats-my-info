//
//  DetectResultController.swift
//  thats my info
//
//  Created by Cory Kim on 19/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import LBTATools

struct Result {
    var title: String
    var numberOfDetect: Int
}

class DetectResultCell: LBTAListCell<Result> {
    
}

class DetectResultController: LBTAListController<DetectResultCell, Result> {

    override func viewDidLoad() {
        super.viewDidLoad()

        items = [
            .init(title: "1", numberOfDetect: 2)
        ]
    }


}
