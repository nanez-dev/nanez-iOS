//
//  SelectEmailView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import UIKit
import SnapKit
import Then

class SelectEmailView: UIView {
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    private var emailAuthButtonBottomConstraint: Constraint?
    
    let backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let topTitleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "회원가입"
        $0.textColor = .black
        $0.font = UIFont(name: "SUIT-Bold", size: 18)
        $0.textAlignment = .center
    }
    
    let navigationView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let progressView = UIProgressView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setProgress(0.32, animated: true)
        $0.trackTintColor = #colorLiteral(red: 0.8523480296, green: 0.924305737, blue: 0.9935916066, alpha: 1)
    }
    
    let mainLabelLine1 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "로그인에 사용할"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let mainLabelLine2 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "이메일을 입력해주세요!"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let detailLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "아이디로 사용됩니다 :)"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let emailLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "이메일"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    let emailTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.backgroundColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
//        $0.text = "korea6370@naver.com"
        $0.attributedPlaceholder = NSAttributedString(string: "이메일을 입력해주세요", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
    }
    
    let emailAuthButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("인증번호 전송", for: .normal)
        $0.backgroundColor = UIColor(named: "mainturquoise") ?? UIColor()
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 12
    }
    
    let authView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
    }
    
    let authNumberTextField = UITextField().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        $0.backgroundColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.borderStyle = .roundedRect
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.attributedPlaceholder = NSAttributedString(string: "인증번호를 입력해주세요.", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        $0.keyboardType = .numberPad
        $0.isHidden = true
    }
    
    let countdownLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .darkGray
        $0.backgroundColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
    }
    
    let resendButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("재전송", for: .normal)
        $0.setTitleColor(mainturquoise, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.3959840536, green: 0.7506515384, blue: 0.7695786357, alpha: 1)
        
        $0.isHidden = true
    }
    
    let nextButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.isEnabled = false
    }
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainLabelLine1, mainLabelLine2, detailLabel]).then {
            $0.axis = .vertical
            $0.spacing = 7
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(topTitleLabel)
        addSubview(progressView)
        addSubview(labelStackView)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(emailAuthButton)
        addSubview(nextButton)
        
        addSubview(authView)
        authView.addSubview(authNumberTextField)
        authView.addSubview(countdownLabel)
        addSubview(resendButton)
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        topTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(backButton.snp.bottom).offset(1)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        labelStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(progressView.snp.bottom).offset(50)
            $0.trailing.equalToSuperview().offset(-47)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(labelStackView)
            $0.top.equalTo(labelStackView.snp.bottom).offset(35)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        emailAuthButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }

    func updateEmailAuthButtonPosition(isAuthVisible: Bool) {
        if isAuthVisible {
            authView.snp.makeConstraints {
                $0.top.equalTo(emailTextField.snp.bottom).offset(15)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.9)
                $0.height.equalTo(50)
            }
            
            authNumberTextField.snp.remakeConstraints {
                $0.leading.equalToSuperview()
                $0.top.equalToSuperview()
                $0.height.equalTo(50)
                $0.trailing.equalTo(countdownLabel.snp.leading).offset(-10)
            }
            
            countdownLabel.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.trailing.equalToSuperview()
                $0.width.height.equalTo(50)
            }
            
            emailAuthButton.snp.remakeConstraints {
                $0.top.equalTo(authNumberTextField.snp.bottom).offset(15)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.9)
                $0.height.equalTo(50)
            }
            
            resendButton.snp.remakeConstraints {
                $0.leading.equalTo(emailAuthButton.snp.leading)
                $0.trailing.equalTo(emailAuthButton.snp.trailing)
                $0.top.equalTo(emailAuthButton.snp.bottom).offset(15)
                $0.height.equalTo(50)
            }
            self.layoutIfNeeded()
        }
    }
    
    func updateEmailAuthButtonState(isEnabled: Bool) {
        emailAuthButton.isEnabled = isEnabled
        emailAuthButton.backgroundColor = isEnabled ? UIColor(named: "mainturquoise") : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        let title = isEnabled ? "인증 확인" : "인증번호 전송"
        emailAuthButton.setTitle(title, for: .normal)
    }
    
    func updateEmailAuthButtonTitle(isVerified: Bool) {
        let title = isVerified ? "인증 확인" : "인증번호 전송"
        emailAuthButton.setTitle(title, for: .normal)
    }
}
