//
//  TermsConditionView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/9/23.
//

import UIKit
import SnapKit
import Then

class TermsConditionView: UIView {
    
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() }
    var viewModel: TermsConditionViewModel?

    let backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel = UILabel().then {
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
        $0.setProgress(0.16, animated: true)
        $0.trackTintColor = #colorLiteral(red: 0.8523480296, green: 0.924305737, blue: 0.9935916066, alpha: 1)
    }
    
    let logoImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "Na'NezLogo")
    }
    
    let greetingLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        let resultString = partitialColor("안녕하세요. 나네입니다.", "나네", mainturquoise)
        $0.attributedText = resultString
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    let descriptionLabel1 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "나네 서비스 이용을 위한"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    let descriptionLabel2 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "필수 이용 약관 동의가 필요합니다."
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    
    let agreeTitle = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: "약관 전체 동의하기", attributes: attributes), for: .normal)
        $0.setImage(UIImage(named: "unCheckMark"), for: .normal)
        $0.tintColor = UIColor(named: "mainturquoise")
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = #colorLiteral(red: 0.9940844178, green: 0.9839119315, blue: 0.9757705331, alpha: 1)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.9931281209, green: 0.9880107045, blue: 0.9755539298, alpha: 1)
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 12
        
        $0.contentHorizontalAlignment = .left
        
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 3, right: 0)
    }

    let checkboxButton1 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "unCheckMark"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel1 = UILabel().then {
        let title = "(필수) 나네 서비스 이용 약관 동의"
        if title.contains("(필수)") {
            let redText = "(필수)"
            let redColor = UIColor.red
            let attributedTitle = partitialColor(title, redText, redColor)
            $0.attributedText = attributedTitle
        }
        else {
            $0.text = title
            $0.textColor = .black
        }
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let selectButton1 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let checkboxButton2 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "unCheckMark"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel2 = UILabel().then {
        let title = "(필수) 개인정보 수집/이용 약관 동의"
        if title.contains("(필수)") {
            let redText = "(필수)"
            let redColor = UIColor.red
            let attributedTitle = partitialColor(title, redText, redColor)
            $0.attributedText = attributedTitle
        }
        else {
            $0.text = title
            $0.textColor = .black
        }
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let selectButton2 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let checkboxButton3 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "unCheckMark"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel3 = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.text = "(선택) 홍보성 SMS/메일 수신 동의"
        $0.textColor = .black
    }
    
    let selectButton3 = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("보기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    
    let agreeButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("동의합니다", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func partitialColor(_ string: String, _ selectRange: String, _ selectColor: UIColor) -> NSAttributedString {
        let originalText = string
        let attributedString = NSMutableAttributedString(string: originalText)
        if let range = originalText.range(of: selectRange) {
            attributedString.addAttribute(.foregroundColor, value: selectColor, range: NSRange(range, in: originalText))
        }
        
        return attributedString
    }

    private func setupLayout() {
                
        addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(titleLabel)
        addSubview(progressView)
        addSubview(logoImageView)
        addSubview(greetingLabel)
        addSubview(descriptionLabel1)
        addSubview(descriptionLabel2)
        
        addSubview(agreeTitle)
        
        addSubview(checkboxButton1)
        addSubview(titleLabel1)
        addSubview(selectButton1)
        
        addSubview(checkboxButton2)
        addSubview(titleLabel2)
        addSubview(selectButton2)
        
        addSubview(checkboxButton3)
        addSubview(titleLabel3)
        addSubview(selectButton3)
        
        addSubview(agreeButton)
        
        navigationView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(backButton.snp.bottom).offset(1)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        greetingLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        descriptionLabel1.snp.makeConstraints {
            $0.top.equalTo(greetingLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        descriptionLabel2.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel1.snp.bottom).offset(3)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        agreeTitle.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel2.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        
        checkboxButton1.snp.makeConstraints {
            $0.top.equalTo(agreeTitle.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(40)
        }
        
        titleLabel1.snp.makeConstraints {
            $0.top.equalTo(agreeTitle.snp.bottom).offset(44)
            $0.left.equalTo(checkboxButton1.snp.right).offset(10)
        }
        
        selectButton1.snp.makeConstraints {
            $0.top.equalTo(agreeTitle.snp.bottom).offset(37)
            $0.right.equalToSuperview().offset(-40)
        }
        
        checkboxButton2.snp.makeConstraints {
            $0.top.equalTo(checkboxButton1.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(40)
        }
        
        titleLabel2.snp.makeConstraints {
            $0.top.equalTo(checkboxButton1.snp.bottom).offset(34)
            $0.left.equalTo(checkboxButton2.snp.right).offset(10)
        }
        
        selectButton2.snp.makeConstraints {
            $0.top.equalTo(checkboxButton1.snp.bottom).offset(27)
            $0.right.equalToSuperview().offset(-40)
        }
        
        checkboxButton3.snp.makeConstraints {
            $0.top.equalTo(checkboxButton2.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(40)
        }
        
        titleLabel3.snp.makeConstraints {
            $0.top.equalTo(checkboxButton2.snp.bottom).offset(34)
            $0.left.equalTo(checkboxButton3.snp.right).offset(10)
        }
        
        selectButton3.snp.makeConstraints {
            $0.top.equalTo(checkboxButton2.snp.bottom).offset(27)
            $0.right.equalToSuperview().offset(-40)
        }
        
        agreeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }

}
