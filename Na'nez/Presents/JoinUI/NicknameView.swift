//
//  NicknameView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/5/23.
//

import UIKit
import SnapKit
import Then

class NicknameView: UIView {
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    var checkButtonVerticalConstraint: Constraint?

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
        $0.setProgress(0.66, animated: true)
        $0.trackTintColor = #colorLiteral(red: 0.8523480296, green: 0.924305737, blue: 0.9935916066, alpha: 1)
    }
    
    let mainLabelLine1 = UILabel().then {
        $0.text = "나네에서 부를"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let mainLabelLine2 = UILabel().then {
        $0.text = "이름을 정해주세요!"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let detailLabel = UILabel().then {
        $0.text = "나네에서 부를 이름을 입력해주세요:)"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let titleLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
    }
    
    let nickTextField = UITextField().then {
//        $0.text = "xlvvlx"
        $0.textColor = .black
        $0.borderStyle = .roundedRect
        $0.backgroundColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.masksToBounds = true
        $0.keyboardType = .default
        $0.font = UIFont(name: "SUIT-Regular", size: 13.0)
        $0.attributedPlaceholder = NSAttributedString(string: "이름을 입력해주세요.", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
    }
    
    let checkButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("중복 확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.isEnabled = false
    }
    
    let nextButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.isEnabled = false
    }
    
    let notMatchLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "* 이미 사용 중인 닉네임입니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.numberOfLines = 0
        $0.isHidden = true
    }
    
    let canMatchLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "* 사용 가능한 닉네임 입니다."
        $0.textColor = #colorLiteral(red: 0.2625362277, green: 0.6258890629, blue: 0.9609254003, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.numberOfLines = 0
        $0.isHidden = true
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
        addSubview(nickTextField)
        addSubview(checkButton)
        addSubview(nextButton)
        
        addSubview(notMatchLabel)
        addSubview(canMatchLabel)
        
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
        
        nickTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(50)
        }

        checkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            checkButtonVerticalConstraint = $0.top.equalTo(nickTextField.snp.bottom).offset(10).constraint
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        notMatchLabel.snp.makeConstraints {
            $0.top.equalTo(nickTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        canMatchLabel.snp.makeConstraints {
            $0.top.equalTo(nickTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}

