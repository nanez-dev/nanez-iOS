//
//  NickNameView.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/28.
//


import UIKit
//import DropDown

class NickNameView: UIView {
    
    
    //    //프로그레스뷰
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.8, animated: true) // Initial progress value
        return progressView
    }()
    
    let mainLabelLine1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "나네에서 부를"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    let mainLabelLine2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이름을 정해주세요!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "향수 추천에 사용됩니다 :)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let doublecheckButton: UIButton = {
       let checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setTitle("중복확인", for: .normal)
        checkButton.backgroundColor = .none
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //checkButton.tintColor = .blue
        checkButton.setTitleColor(.systemBlue, for: .normal)
        return checkButton
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
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 17
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.masksToBounds = true
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "불리고 싶은 이름을 작성해주세요!", attributes: [
            .font: UIFont.systemFont(ofSize: 13.0, weight: .medium)
        ])
        return textField
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI() {
        
        addSubview(progressView)
        addSubview(labelStackView)
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(nextButton)
        addSubview(doublecheckButton)

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
            
            doublecheckButton.leadingAnchor.constraint(equalTo: labelStackView.leadingAnchor, constant: 250),
            doublecheckButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 33),
            doublecheckButton.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor),


            //next Button
            nextButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -10),
            //nextButton.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 385),
            nextButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -85),
            //nextButton.trailingAnchor.constraint(equalTo: check_textField.trailingAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 344),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
