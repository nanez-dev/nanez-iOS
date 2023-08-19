//
//  LoginView.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/19.
//

import UIKit
@objc

protocol LoginViewDelegate {
    func loginButtonClick(_ loginview: LoginView, email:String, pw:String)
    func joinButtonClock(_ loginview: LoginView)
    
//    func didChangeEmail(_ loginview: LoginView, email: String)
//    func didChangePw(_ loginview: LoginView, pw: String)
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate? // 델리게이트 약한 선언
    
    
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() } // 버튼에 주로쓰이는 청록
    
    let emailField: UITextField = {
        let emailField = UITextField()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.borderStyle = .roundedRect
        emailField.layer.cornerRadius = 17
        emailField.layer.borderWidth = 0.5
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.layer.masksToBounds = true
        emailField.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        return emailField
    }()

    let pwField: UITextField = {
        let pwField = UITextField()
        pwField.translatesAutoresizingMaskIntoConstraints = false
        pwField.borderStyle = .roundedRect
        pwField.layer.cornerRadius = 17
        pwField.layer.borderWidth = 0.5
        pwField.layer.borderColor = UIColor.lightGray.cgColor
        pwField.layer.masksToBounds = true
        pwField.attributedPlaceholder = NSAttributedString(string: "패스워드를 입력해주세요", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        return pwField
    }()

    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = UIColor(named: "mainturquoise") ?? UIColor()
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.layer.cornerRadius = 17
        return loginButton
    }()

    let joinButton: UIButton = {
        let joinButton = UIButton()
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.setTitle("회원가입", for: .normal)
        joinButton.backgroundColor = .white
        joinButton.setTitleColor(UIColor(named: "mainturquoise") ?? UIColor(), for: .normal)
        joinButton.layer.cornerRadius = 17
        joinButton.layer.borderWidth = 1
        joinButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        joinButton.layer.borderColor = UIColor(named: "mainturquoise")?.cgColor ?? UIColor().cgColor
        return joinButton
    }()

//    let logo: UILabel = {
//        let logo = UILabel()
//        logo.text = "LOGO가 들어갈 자리"
//        logo.translatesAutoresizingMaskIntoConstraints = false
//        return logo
//    }()

    private var brandImgView = UIImageView().then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(named: "FullLogo")
    }
    let logo : UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "FullLogo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let notice: UILabel = {
        let notice = UILabel()
        notice.text = "아직 나네를 시작하지 않으셨나요?"
        notice.textColor = .gray
        notice.font = UIFont.systemFont(ofSize: 14)
        notice.translatesAutoresizingMaskIntoConstraints = false
        return notice
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        
    }

    //버튼 활동
    private func configure() {
        self.loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
        self.joinButton.addTarget(self, action: #selector(joinButtonClick), for: .touchUpInside)
    }

    private func setupViews() {
        addSubview(logo)
        addSubview(emailField)
        addSubview(pwField)
        addSubview(loginButton)
        addSubview(joinButton)
        addSubview(notice)

        // Set up the constraints for each view component here
        // ...
        
        NSLayoutConstraint.activate([
            // logo constraints
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 90),
            logo.widthAnchor.constraint(equalToConstant: 120),   // 원하는 가로 크기로 변경
            logo.heightAnchor.constraint(equalToConstant: 70),
            
            // emailField constraints
            emailField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 47),
            emailField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 70),
            emailField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -47),
            emailField.heightAnchor.constraint(equalToConstant: 47),
            
            // pwField constraints
            pwField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            pwField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            pwField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            pwField.heightAnchor.constraint(equalTo: emailField.heightAnchor),
            
            // loginButton constraints
            loginButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            loginButton.topAnchor.constraint(equalTo: pwField.bottomAnchor, constant: 25),
            loginButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            
            // joinButton constraints
            joinButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            joinButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 280),
            joinButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            joinButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            
            // notice constraints
            notice.centerXAnchor.constraint(equalTo: centerXAnchor),
            notice.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80)
            ])
    }
}

//사용자 버튼 클릭시 활동 처리
extension LoginView {
    @objc func loginButtonClick() {
        delegate?.loginButtonClick(self, email: emailField.text ?? "", pw: pwField.text ?? "")
    }
    @objc func joinButtonClick() {
        delegate?.joinButtonClock(self)
    }
    
}
