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
        isFormValid.value = naverId?.isEmpty == false && phone?.count ?? 0 >= 9 && isNaverAuthSuccess ?? false
    }
    
    func toUserInfo() -> UserInfo {
        let userInfo = UserInfo(naverId: naverId ?? "", phone: phone ?? "", accessToken: accessToken ?? "")
        return userInfo
    }
}
