//
//  MyInfoView.swift
//  Na'nez
//
//  Created by 최지철 on 2023/10/13.
//

import UIKit

class LoginyetView: BaseView {
    
    private let titleLabel = UILabel().then {
        $0.text = "로그인 후 이용하실 수 있습니다."
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(hexString: "#333333")
        $0.sizeToFit()
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "로그인 하시면 더 많은 정보를 살펴 보실 수 있습니다"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(hexString: "#666666")
        $0.sizeToFit()
    }
    
    private let loginBtn = UIButton().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .mainturquoise
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
    }
    

    override func configure() {
        
    }
 
    override func addview() {
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(loginBtn)
    }
    
    override func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(52)
        }
        self.subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom)
        }
        self.loginBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(32)
            $0.width.equalTo(152)
            $0.height.equalTo(52)
        }
    }
}
