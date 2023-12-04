//
//  PasswordView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/3/23.
//

import UIKit
import SnapKit
import Then

class PasswordView: UIView {
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    
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
        $0.setProgress(0.5, animated: true)
        $0.trackTintColor = #colorLiteral(red: 0.8523480296, green: 0.924305737, blue: 0.9935916066, alpha: 1)
    }
    
    let mainLabelLine1 = UILabel().then {
        $0.text = "로그인에 사용할"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let mainLabelLine2 = UILabel().then {
        $0.text = "비밀번호를 입력해주세요!"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let detailLabel = UILabel().then {
        $0.text = "비밀번호는 영문+숫자 조합의 8~20자리입니다:)"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let titleLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    let textField = UITextField().then {
        $0.textColor = .black
        $0.borderStyle = .roundedRect
        $0.backgroundColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
        $0.isSecureTextEntry = true
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요.", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
    }
    
    let checkTextField = UITextField().then {
        $0.textColor = .black
        $0.borderStyle = .roundedRect
        $0.backgroundColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
        $0.isSecureTextEntry = true
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 다시 한 번 입력해주세요.", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
    }
    
    let nextButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.isEnabled = false
    }
    
    lazy var labelStackView = UIStackView(arrangedSubviews: [mainLabelLine1, mainLabelLine2, detailLabel]).then {
        $0.axis = .vertical
        $0.spacing = 7
    }
    
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
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(checkTextField)
        addSubview(nextButton)
        
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
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(labelStackView)
            $0.top.equalTo(labelStackView.snp.bottom).offset(35)
        }
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(50)
        }
        
        checkTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(12)
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
}
