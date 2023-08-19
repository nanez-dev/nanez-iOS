//
//  LoginViewController.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/19.
//


import UIKit
import SnapKit  //오토레이아웃 좀 더 편하게
import Then

class LoginViewController: UIViewController {
    private let loginview : LoginView = LoginView(frame: .zero)
    private let loginAPI = LoginService()
    private var userInfo = UserInfo()
    
    private func configure() {
        self.loginview.emailField.delegate = self
        self.loginview.pwField.delegate = self
        self.loginview.delegate = self
        self.loginview.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        self.view.backgroundColor = .white
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginview)
        configure()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}

extension LoginViewController: LoginViewDelegate {


    func loginButtonClick(_ loginview: LoginView, email: String, pw: String) {
        loginAPI.postLogin(email: email, Pw: pw) { response in
            switch response {
            case .success(let data) :
                self.userInfo.access_token = data.access_token
                self.userInfo.refresh_token = data.refresh_token
            case .failure(let error) :
                print(error)
            }
        }
            
        
    }
    
    func joinButtonClock(_ loginview: LoginView) {
        print("가입")
    }
    
    
}
