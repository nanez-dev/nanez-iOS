//
//  AnotherLoginViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import RxSwift

class AnotherLoginViewController: UIViewController {
    private let anotherLoginView = AnotherLoginView(frame: .zero)
    private var viewModel = AnotherLoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout() {
        view.addSubview(anotherLoginView)
        anotherLoginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        anotherLoginView.onAppleLoginClicked = { [weak self] in
            self?.viewModel.performAppleLogin()
        }

        anotherLoginView.onNaverLoginClicked = { [weak self] in
            self?.viewModel.performNaverLogin()
        }

        anotherLoginView.onGoogleLoginClicked = { [weak self] in
            self?.viewModel.performGoogleLogin()
        }

        anotherLoginView.onEmailLoginClicked = { [weak self] in
            self?.showEmailLogin()
        }

        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    print("로그인 성공")
                } else {
                    print("로그인 실패")
                }
            }).disposed(by: disposeBag)
    }
    
    private func showEmailLogin() {
        let emailLoginVC = EmailLoginViewController()
        
        let emailLoginUseCase = EmailLoginUseCase(repository: EmailLoginRepository(loginService: LoginService()))
        let emailLoginViewModel = EmailLoginViewModel(useCase: emailLoginUseCase)
        
        emailLoginVC.setViewModel(viewModel: emailLoginViewModel)
        navigationController?.pushViewController(emailLoginVC, animated: true)
    }
    
}

