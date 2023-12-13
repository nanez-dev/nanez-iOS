//
//  EmailLoginViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import RxSwift
import RxCocoa

class EmailLoginViewController: UIViewController {
    private let emailLoginView: EmailLoginView = EmailLoginView(frame: .zero)
    private var viewModel: EmailLoginViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupBindings()
    }
    
    private func configure() {
        self.view.addSubview(emailLoginView)
        
        self.emailLoginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        view.backgroundColor = .white
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else {
            print("ViewModel is not initialized")
            return
        }
        
        emailLoginView.onLoginButtonClicked = { [weak self] email, password in
            self?.viewModel.login(email: email, password: password)
        }

        emailLoginView.onJoinButtonClicked = { [weak self] in
            print("회원가입 버튼 클릭")
            self?.showTermsConditionView()
        }

        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    // 로그인 성공 처리, 예: 다른 화면으로 이동
                    self?.emailLoginView.indicateEmailAvailable()
                    print("로그인 성공")
                } else {
                    // 로그인 실패 처리, 예: 에러 메시지 표시
                    self?.emailLoginView.indicateLoginFailure()
                    print("로그인 실패")
                }
            }).disposed(by: disposeBag)
        
    }
    
    func setViewModel(viewModel: EmailLoginViewModel) {
        self.viewModel = viewModel
    }
    
    private func showTermsConditionView() {
        let termsRepository = TermsRepository()
        let termsUseCase = TermsUseCase(repository: termsRepository)
        let termsViewModel = TermsConditionViewModel(termsUseCase: termsUseCase)
        let termsConditionVC = TermsConditionViewController(viewModel: termsViewModel)
        termsConditionVC.modalPresentationStyle = .fullScreen
        present(termsConditionVC, animated: true)
    }
}

