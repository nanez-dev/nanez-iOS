//
//  RecommendLoginView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import SnapKit
import Then

class RecommendLoginView: UIView {
    
    var onKakaoLoginClicked: (() -> Void)?
    var onAnotherLoginClicked: (() -> Void)?
    var onStartGuestClicked: (() -> Void)?
            
    private let mainLogo = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "loginLogoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let kakaoLoginButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.9939203858, green: 0.8970287442, blue: 0.01170333382, alpha: 1)
        $0.setTitleColor(.black, for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "카카오로 시작하기", attributes: attributes), for: .normal)
        $0.setImage(UIImage(systemName: "message.fill"), for: .normal)
        $0.tintColor = .black
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        $0.layer.cornerRadius = 12
    }
    
    private let anotherLoginButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: "다른 방법으로 로그인하기", attributes: attributes), for: .normal)
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.9666457772, green: 0.9563897252, blue: 0.9230519533, alpha: 1)
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 12
    }
    
    let startGuestButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: "게스트로 시작하기", attributes: attributes), for: .normal)
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(.lightGray, for: .normal)
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .lightGray
        $0.imageView?.contentMode = .scaleAspectFit
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainLogo)
        addSubview(kakaoLoginButton)
        addSubview(anotherLoginButton)
        addSubview(startGuestButton)
        
        mainLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(150)
            $0.width.height.equalTo(350)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(anotherLoginButton.snp.top).offset(-8)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        anotherLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(startGuestButton.snp.top).offset(-8)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        startGuestButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }

        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureActions() {
        anotherLoginButton.addTarget(self, action: #selector(anotherLoginButtonClicked), for: .touchUpInside)
    }
    
    @objc func anotherLoginButtonClicked() {
        onAnotherLoginClicked?()
    }

}
