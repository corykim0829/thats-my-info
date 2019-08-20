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
    
    var naverId: String? { didSet { checkValidity() } }
    var phone: String? { didSet { checkValidity() } }
    var isNaverAuthSuccess: Bool? { didSet { checkValidity() }}
    var accessToken: String?
    
    fileprivate func checkValidity() {
        isFormValid.value = naverId?.isEmpty == false && phone?.isEmpty == false && isNaverAuthSuccess ?? false
    }
}
