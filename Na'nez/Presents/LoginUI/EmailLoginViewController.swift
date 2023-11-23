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

        self.view.addSubview(emailLoginView)
        
        configure()
        setupBindings()
    }
    
    private func configure() {
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
            // 회원가입 로직 처리
            print("회원가입 버튼 클릭")
        }

        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    // 로그인 성공 처리, 예: 다른 화면으로 이동
                    print("로그인 성공")
                } else {
                    // 로그인 실패 처리, 예: 에러 메시지 표시
//                    self?.emailLoginView.showFailureMessage()
                    print("로그인 실패")
                }
            }).disposed(by: disposeBag)
    }
    
    func setViewModel(viewModel: EmailLoginViewModel) {
        self.viewModel = viewModel
    }
}
