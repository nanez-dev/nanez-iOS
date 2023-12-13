//
//  SurveyView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/6/23.
//

import UIKit
import SnapKit
import Then

class SurveyView: UIView {
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    let numberOfRows = 4
    let numberOfColumns = 5
    
    let incenseButtonInfo: [(imageName: String, title: String)] = [
        ("citrus", "시트러스"), ("fruity", "프루티"), ("floral", "플로럴"), ("whiteFloral", "화이트플로럴"), ("spicy", "스파이시"),
        ("powdery", "파우더리"), ("fresh", "프레시"), ("aqua", "아쿠아"), ("aroma", "아로마"), ("woody", "우디"),
        ("amber", "앰버"), ("musk", "머스크"), ("nutty", "너티"), ("vanilla", "바닐라"), ("green", "그린"),
        ("sweet", "스위트"), ("leather", "레더"), ("smoky", "스모키")
    ]
    
    var buttons: [UIButton] = []
    
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
        $0.setProgress(0.82, animated: true)
        $0.trackTintColor = #colorLiteral(red: 0.8523480296, green: 0.924305737, blue: 0.9935916066, alpha: 1)
    }
    
    let mainLabelLine1 = UILabel().then {
        $0.text = "마지막 질문!"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let mainLabelLine2 = UILabel().then {
        $0.text = "좋아하는 향 있어요?"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    let detailLabel = UILabel().then {
        $0.text = "가장 취향에 맞는 향을 한 가지만 선택해주세요:)"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
    }

    
    lazy var labelStackView = UIStackView(arrangedSubviews: [mainLabelLine1, mainLabelLine2, detailLabel]).then {
        $0.axis = .vertical
        $0.spacing = 7
    }
    
    let buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 40
        $0.distribution = .equalSpacing
        $0.alignment = .fill
    }
    
    let skipButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("건너뛰기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.setTitleColor(mainturquoise, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = mainturquoise.cgColor
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let nextButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.isEnabled = false
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        var buttonIndex = 0
        
        for _ in 0..<numberOfRows {
            let horizontalStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.spacing = 10
                $0.distribution = .fillEqually
                $0.alignment = .fill
            }
            
            for _ in 0..<numberOfColumns {
                if buttonIndex < incenseButtonInfo.count {
                    let buttonInfo = incenseButtonInfo[buttonIndex]
                    let button = CustomSurveyButton(imageName: buttonInfo.imageName, title: buttonInfo.title).then {
                        $0.translatesAutoresizingMaskIntoConstraints = false
                    }
                    horizontalStackView.addArrangedSubview(button)
                    buttons.append(button)
                    
                    button.snp.makeConstraints {
                        $0.height.equalTo(50)
                    }
                    
                    buttonIndex += 1
                } else {
                    let placeholderView = UIView()
                    horizontalStackView.addArrangedSubview(placeholderView)
                }
            }
            buttonStackView.addArrangedSubview(horizontalStackView)
            
            horizontalStackView.snp.makeConstraints {
                $0.height.equalTo(50)
            }
        }
    }

    private func setupUI() {
        addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(topTitleLabel)
        addSubview(progressView)
        addSubview(labelStackView)
        
        addSubview(buttonStackView)
        
        addSubview(skipButton)
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
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top).offset(-10)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }

    }
}
