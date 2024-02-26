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
        self.navigationItem.hidesBackButton = true
       
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
        anotherLoginView.onEmailLoginClicked = { [weak self] in
            self?.showEmailLogin()
        }
        
        anotherLoginView.backButton.rx.tap
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in self?.navigationController?.popViewController(animated: true) }
            .disposed(by: disposeBag)

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
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(emailLoginVC, animated: true)
    }
    
}

