//
//  PasswordView.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/25.
//

import UIKit
@objc
protocol PassWordViewDelegate: AnyObject {
    func nextButtonTapped()
}

class PassWordView: UIView {
    
    weak var delegate : PassWordViewDelegate?
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.2, animated: true) // Initial progress value
        return progressView
    }()
    
    
    let mainLabelLine1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "로그인에 사용할"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    let mainLabelLine2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호를 입력해주세요!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아이디로 사용됩니다 :)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.placeholder = "숫자, 영문, 특수문자 8~16자 입력"
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 17
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "숫자, 영문, 특수문자 8~16자 입력", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        return textField
    }()
    
    
    let check_textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 17
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true  //비밀번호 보이지 않도록
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 다시 한 번 입력해주세요", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        return textField
    }()
    
    
    let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("다음으로", for: .normal)
        nextButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        nextButton.layer.cornerRadius = 17
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return nextButton
    }()
    

    lazy var labelStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [mainLabelLine1, mainLabelLine2, detailLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 7
            return stackView
        }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupButtonAction()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(progressView)
        addSubview(labelStackView)
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(check_textField)
        addSubview(nextButton)
        
        
        NSLayoutConstraint.activate([
            
            //progressView
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50), // 네비게이션 바 바로 밑에 배치
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            labelStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 50),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -47),
            
            
            //titleLabel
            titleLabel.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 35),
            titleLabel.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor),
            
            
            //textFieldLabel
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -9),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            //textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textField.widthAnchor.constraint(equalToConstant: 327), // 가로 327
            textField.heightAnchor.constraint(equalToConstant: 50), // 세로 47
            
            //check password textField
            check_textField.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            check_textField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            //check_textField.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            check_textField.widthAnchor.constraint(equalToConstant: 327),
            check_textField.heightAnchor.constraint(equalToConstant: 50),
            
            //next Button
            nextButton.leadingAnchor.constraint(equalTo: check_textField.leadingAnchor, constant: -10),
            //nextButton.topAnchor.constraint(equalTo: check_textField.bottomAnchor, constant: 285),
            nextButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -85),
            //nextButton.trailingAnchor.constraint(equalTo: check_textField.trailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 344),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    


    private func setupButtonAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    //성별 선택 화면으로 넘어감 
    @objc private func nextButtonTapped() {
            print("TAPPED")
            delegate?.nextButtonTapped()
        }

}

