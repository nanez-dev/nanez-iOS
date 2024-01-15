//
//  BeforeLoginView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/15/24.
//

import UIKit
import SnapKit
import Then

class BeforeLoginView: UIView {
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
    
    let loginBtn = UIButton().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .mainturquoise
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(loginBtn)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(52)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom)
        }
        
        loginBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.subTitleLabel.snp.bottom).offset(32)
            $0.width.equalTo(152)
            $0.height.equalTo(52)
        }
    }
}
