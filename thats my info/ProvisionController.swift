//
//  ProvisionController.swift
//  thats my info
//
//  Created by Cory Kim on 20/08/2019.
//  Copyright © 2019 Relationship oriented. All rights reserved.
//

import UIKit

class ProvisionController: UIViewController {

    fileprivate let customDismissNavBar = CustomDismissNavBar(title: "개인정보 이용약관", backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1), tintColor: .white)
    fileprivate let topToSafeAreaView = UIView(backgroundColor: #colorLiteral(red: 0.1333333333, green: 0.5889699587, blue: 0.9647058824, alpha: 1))
    
    lazy var provisionTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 12, weight: .light)
        tv.isEditable = false
        tv.text = provisionText
        return tv
    }()
    let provisionText: String =
        """
<관계지향적>은 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.
    
    
1. 개인정보의 처리 목적
 <관계지향적>은 개인정보를 다음의 목적을 위해 처리합니다.
 처리한 개인정보는 다음 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.
 가. 재화 또는 서비스 제공
    
    
2. 개인정보 수집 종류
 - 개인정보 항목 : 이메일, 휴대전화번호, 로그인ID, 이름
 - 보유기간 : 지체없이 파기
    
    
3. 개인정보의 처리 및 보유 기간
 ① <관계지향적>은 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터
 개인정보 수집시에 동의 받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.
 ② 개인정보 처리 및 보유 기간은 다음과 같습니다.
 개인정보는 수집.이용에 관한 동의일로부터 지체없이 파기까지 위 이용목적을 위하여 보유.이용됩니다.
    
    
4. 정보주체와 법정대리인의 권리·의무 및 그 행사방법
 이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.
 ① 정보주체는 <관계지향적>에 대해 언제든지 개인정보 열람, 정정, 삭제, 처리정지 요구 등의 권리를 행사할 수 있습니다.
 ② 제1항에 따른 권리 행사는 <관계지향적>에 대해 개인정보 보호법 시행령 제41조 제1항에 따라
 서면, 전자우편 등을 통하여 하실 수 있으며 <관계지향적>은 이에 대해 지체 없이 조치하겠습니다.
 ③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.
 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
 ④ 개인정보 열람 및 처리정지 요구는 개인정보보호법 제35조 제5항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
 ⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
 ⑥ <관계지향적>은 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
    
    
5. 처리하는 개인정보의 항목 작성
 ① <관계지향적>은 다음의 개인정보 항목을 처리하고 있습니다.
   - 필수항목 : 이메일, 휴대전화번호, 로그인ID, 이름
    
    
6. 개인정보의 파기
 <관계지향적>은 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다.
    
    
7. 개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항
 <관계지향적>은 정보주체의 이용정보를 저장하고 수시로 불러오는 ‘쿠키’를 사용하지 않습니다.
    
    
8. 개인정보 보호책임자 작성
 ① <관계지향적>은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의
 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
    ▶ 개인정보 보호책임자
    성명 : 김연수
    직책 : 팀장
    직급 : 팀장
    연락처 : 1577-1577, 7ustis@gmail.com
    
    
9. 개인정보 처리방침 변경
 ① 이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는
 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.
    
    
10. 개인정보의 안전성 확보 조치
 <관계지향적>은 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.
 1. 개인정보의 암호화
  이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어,
  본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.
 2. 개인정보에 대한 접근 제한
  개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며
  침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customDismissNavBar.dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        setupUI()
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(topToSafeAreaView)
        topToSafeAreaView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
        
        view.addSubview(customDismissNavBar)
        customDismissNavBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 48))
        
        view.addSubview(provisionTextView)
        provisionTextView.anchor(top: customDismissNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
    }
}
