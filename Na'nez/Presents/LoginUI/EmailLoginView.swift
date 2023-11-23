//
//  EmailLoginView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import SnapKit
import Then

class EmailLoginView: UIView {
    
    var onLoginButtonClicked: ((String, String) -> Void)?
    var onJoinButtonClicked: (() -> Void)?
    
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    
    private let mainLogo = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "emailLoginMainLogo")
        $0.contentMode = .scaleAspectFit
    }
    
    let emailField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
        $0.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
    }
    
    let pwField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
        $0.attributedPlaceholder = NSAttributedString(string: "패스워드를 입력해주세요", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        $0.isSecureTextEntry = true
    }
    
    private let loginButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor(named: "mainturquoise") ?? UIColor()
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 12
    }
    
    private let noticeLabel = UILabel().then {
        $0.text = "아직 나네를 시작하지 않으셨나요?"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let joinButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(UIColor(named: "mainturquoise") ?? UIColor(), for: .normal)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.borderColor = UIColor(named: "mainturquoise")?.cgColor ?? UIColor().cgColor
    }
    
    let failureNoticeLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func configure() {
        self.loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        self.joinButton.addTarget(self, action: #selector(joinButtonClick), for: .touchUpInside)
    }
    
    private func setupViews() {
        addSubview(mainLogo)
        addSubview(emailField)
        addSubview(pwField)
        addSubview(loginButton)
        addSubview(joinButton)
        addSubview(noticeLabel)
        
        addSubview(failureNoticeLabel)
        
        mainLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(90)
            $0.width.equalTo(170)
            $0.height.equalTo(120)
        }
        
        emailField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLogo.snp.bottom).offset(70)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        pwField.snp.makeConstraints {
            $0.leading.trailing.height.equalTo(emailField)
            $0.top.equalTo(emailField.snp.bottom).offset(12)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(emailField)
            $0.top.equalTo(pwField.snp.bottom).offset(25)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        joinButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(emailField)
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(loginButton)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(joinButton.snp.top).offset(-8)
            $0.height.equalTo(50)
        }
        
        failureNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func indicateLoginFailure() {
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.red.cgColor
        pwField.layer.borderWidth = 1
        pwField.layer.borderColor = UIColor.red.cgColor
    }
    
    // 로그인 버튼 클릭 핸들러
    @objc func loginButtonClick() {
        let email = emailField.text ?? ""
        let password = pwField.text ?? ""
        onLoginButtonClicked?(email, password)
    }
    
    // 회원가입 버튼 클릭 핸들러
    @objc func joinButtonClick() {
        onJoinButtonClicked?()
    }
}
