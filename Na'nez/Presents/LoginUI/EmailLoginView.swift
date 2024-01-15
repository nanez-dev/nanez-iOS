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
    
    let backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
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
    
    let loginButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = UIColor(named: "mainturquoise") ?? UIColor()
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 12
    }
    
    let pwQuesLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "회원정보를 잊으셨나요?"
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 11)
    }
    
    let pwFindButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 11),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedTitle = NSAttributedString(string: "비밀번호 찾기", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.setTitleColor(UIColor(red: 0.2638565898, green: 0.6260595918, blue: 0.9594424367, alpha: 1), for: .normal)
        $0.backgroundColor = .white
    }
    
    lazy var pwFindStackView = UIStackView(arrangedSubviews: [pwQuesLabel, pwFindButton]).then {
        $0.axis = .horizontal
        $0.spacing = 7
    }
    
    let noticeLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "아직 나네를 시작하지 않으셨나요?"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let joinButton = UIButton().then {
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
        $0.font = UIFont.systemFont(ofSize: 12)
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
        addSubview(backButton)
        addSubview(mainLogo)
        addSubview(emailField)
        addSubview(pwField)
        addSubview(loginButton)
        
        addSubview(pwFindStackView)
        
        addSubview(joinButton)
        addSubview(noticeLabel)
        
        addSubview(failureNoticeLabel)
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
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
        
        pwFindStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(5)
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
            $0.top.equalTo(pwField.snp.bottom).offset(5)
            $0.leading.equalTo(pwField)
        }
    }
    
    func indicateLoginFailure() {
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.red.cgColor
        pwField.layer.borderWidth = 1
        pwField.layer.borderColor = UIColor.red.cgColor
        
        failureNoticeLabel.text = "* 이메일 또는 비밀번호가 일치하지 않습니다."
        failureNoticeLabel.isHidden = false
        
        loginButton.snp.updateConstraints {
            $0.top.equalTo(pwField.snp.bottom).offset(55)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    func indicateEmailAvailable() {
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = #colorLiteral(red: 0.2638565898, green: 0.6260595918, blue: 0.9594424367, alpha: 1)
        pwField.layer.borderWidth = 1
        pwField.layer.borderColor = #colorLiteral(red: 0.2638565898, green: 0.6260595918, blue: 0.9594424367, alpha: 1)
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

