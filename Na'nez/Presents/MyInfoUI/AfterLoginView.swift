//
//  AfterLoginView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/15/24.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class AfterLoginView: UIView {
    let accordProfileImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
    }
    
    let nicknameLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(hexString: "#333333")
    }
    
    let emailLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .pretendard(.Regular, size: 13)
        $0.textColor = UIColor(hexString: "#666666")
    }
    
    let holdingListCount = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "1"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(hexString: "#333333")
    }
    
    let holdingListLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "보유리스트"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(hexString: "#666666")
    }
    
    lazy var holdingListStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [holdingListCount, holdingListLabel]).then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .center
        }
        return stackView
    }()
    
    let wishListCount = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "4"
        $0.font = .pretendard(.Bold, size: 20)
        $0.textColor = UIColor(hexString: "#333333")
    }
    
    let wishListLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "위시리스트"
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = UIColor(hexString: "#666666")
    }
    
    lazy var wishListStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wishListCount, wishListLabel]).then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .center
        }
        return stackView
    }()
    
    lazy var listStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [holdingListStackView, wishListStackView]).then {
            $0.axis = .horizontal
            $0.spacing = 70
        }
        return stackView
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView().then {
            $0.backgroundColor = UIColor(hexString: "#DADADA")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return view
    }()
    
    lazy var dividerContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(accordProfileImage)
        addSubview(nicknameLabel)
        addSubview(emailLabel)
        addSubview(listStackView)
        
        dividerContainerView.addSubview(dividerView)
        
        accordProfileImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(15)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.accordProfileImage.snp.bottom).offset(10)
        }
        
        emailLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.nicknameLabel.snp.bottom).offset(3)
        }
        
        listStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.emailLabel.snp.bottom).offset(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(20)
            $0.center.equalToSuperview()
        }
        
        listStackView.insertArrangedSubview(dividerContainerView, at: 1)
        
        dividerContainerView.snp.makeConstraints {
            $0.width.equalTo(dividerView.snp.width)
            $0.height.equalTo(listStackView.snp.height)
        }
    }
}
