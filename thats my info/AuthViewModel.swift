//
//  UserInfoViewModel.swift
//  thats my info
//
//  Created by Cory Kim on 20/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import Foundation

class AuthViewModel {
    
    var isFormValid = Bindable<Bool>()
    
    var email: String? { didSet { checkValidity() } }
    var password: String? { didSet { checkValidity() } }
    
    fileprivate func checkValidity() {
        isFormValid.value = email?.isEmpty == false && password?.isEmpty == false
    }
}
