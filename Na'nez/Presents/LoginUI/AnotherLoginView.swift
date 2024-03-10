//
//  AnotherLoginView.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import SnapKit
import Then

class AnotherLoginView: UIView {
    
    var onAppleLoginClicked: (() -> Void)?
    var onNaverLoginClicked: (() -> Void)?
    var onGoogleLoginClicked: (() -> Void)?
    var onEmailLoginClicked: (() -> Void)?
    
    let backButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(named: "Nan'Nez_Back"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let mainLogo = UIImageView().then {
        $0.image = UIImage(named: "loginLogoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let appleLoginButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "애플로 시작하기", attributes: attributes), for: .normal)
        $0.setImage(UIImage(systemName: "apple.logo"), for: .normal)
        $0.tintColor = .white
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -11, bottom: 2, right: 0)
        $0.layer.cornerRadius = 12
    }
    
    private let naverLoginButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = #colorLiteral(red: 0.00641738344, green: 0.7807440162, blue: 0.2361988127, alpha: 1)
        $0.setTitleColor(.white, for: .normal)
        $0.setAttributedTitle(NSAttributedString(string: "네이버로 시작하기", attributes: attributes), for: .normal)
        
        if let originalImage = UIImage(named: "naverIcon") {
            let scaledImage = originalImage.resized(toWidth: 14)
            $0.setImage(scaledImage, for: .normal)
        }

        $0.tintColor = .white
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -11, bottom: 0, right: 0)
        $0.layer.cornerRadius = 12
    }
    
    private let googleLoginButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: "구글로 시작하기", attributes: attributes), for: .normal)
        
        if let originalImage = UIImage(named: "googleIcon") {
            let scaledImage = originalImage.resized(toWidth: 19)
            $0.setImage(scaledImage, for: .normal)
        }
        
        $0.tintColor = .white
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -9, bottom: 0, right: 0)
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.9666457772, green: 0.9563897252, blue: 0.9230519533, alpha: 1)
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 12

    }
    
    private let emailLoginButton = UIButton().then {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle(NSAttributedString(string: "이메일로 로그인하기", attributes: attributes), for: .normal)
        
        if let originalImage = UIImage(named: "emailIcon") {
            let scaledImage = originalImage.resized(toWidth: 21)
            $0.setImage(scaledImage, for: .normal)
        }
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 1, right: 0)
        
        $0.backgroundColor = UIColor.white
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderColor = #colorLiteral(red: 0.9666457772, green: 0.9563897252, blue: 0.9230519533, alpha: 1)
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 12
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backButton)
        addSubview(mainLogo)
        addSubview(appleLoginButton)
        addSubview(naverLoginButton)
        addSubview(googleLoginButton)
        addSubview(emailLoginButton)
        
        backButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(70)
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        mainLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(150)
            $0.width.height.equalTo(350)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(naverLoginButton.snp.top).offset(-8)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        naverLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(googleLoginButton.snp.top).offset(-8)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        googleLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(emailLoginButton.snp.top).offset(-8)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        emailLoginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    private func configureActions() {
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        naverLoginButton.addTarget(self, action: #selector(naverLoginButtonClicked), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(googleLoginButtonClicked), for: .touchUpInside)
        emailLoginButton.addTarget(self, action: #selector(emailLoginButtonClicked), for: .touchUpInside)
    }
    
    @objc func appleLoginButtonClicked() {
        onAppleLoginClicked?()
    }
    
    @objc func naverLoginButtonClicked() {
        onNaverLoginClicked?()
    }
    
    @objc func googleLoginButtonClicked() {
        onGoogleLoginClicked?()
    }
    
    @objc func emailLoginButtonClicked() {
        onEmailLoginClicked?()
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
