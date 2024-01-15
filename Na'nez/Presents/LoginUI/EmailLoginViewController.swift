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
    private let customIndicatorView = CustomIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupBindings()
        configureCustomIndicatorView()
    }
    
    private func configure() {
        self.view.addSubview(emailLoginView)
        
        self.emailLoginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        view.backgroundColor = .white
    }
    
    private func configureCustomIndicatorView() {
        view.addSubview(customIndicatorView)
        customIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        customIndicatorView.isHidden = true
    }
    
    private func setupBindings() {
        guard let viewModel = viewModel else {
            print("ViewModel is not initialized")
            return
        }
        
        emailLoginView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        
        emailLoginView.onLoginButtonClicked = { [weak self] email, password in
            self?.customIndicatorView.isHidden = false
            self?.customIndicatorView.startAnimating()
            self?.viewModel.login(email: email, password: password)
        }

        emailLoginView.onJoinButtonClicked = { [weak self] in
            print("회원가입 버튼 클릭")
            self?.showTermsConditionView()
        }
        
        emailLoginView.pwFindButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showFindPwView()
            }).disposed(by: disposeBag)

        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                self?.customIndicatorView.stopAnimating()
                self?.customIndicatorView.isHidden = true
                
                if isSuccess {
                    self?.emailLoginView.indicateEmailAvailable()
                    print("로그인 성공")
                    self?.showHomeView()
                } else {
                    self?.emailLoginView.indicateLoginFailure()
                    print("로그인 실패")
                }
            }).disposed(by: disposeBag)
        
    }
    
    func setViewModel(viewModel: EmailLoginViewModel) {
        self.viewModel = viewModel
    }
    
    private func showFindPwView() {
        let findPwVC = FindPwViewController()
        findPwVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        findPwVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(findPwVC, animated: true)
    }
    
    private func showTermsConditionView() {
        let termsRepository = TermsRepository()
        let termsUseCase = TermsUseCase(repository: termsRepository)
        let termsViewModel = TermsConditionViewModel(termsUseCase: termsUseCase)
        let termsConditionVC = TermsConditionViewController(viewModel: termsViewModel)
        termsConditionVC.modalPresentationStyle = .fullScreen
        present(termsConditionVC, animated: true)
    }
    
    private func showHomeView() {
        let homeRepository = HomeRepository(homeService: HomeService())
        let homeUseCase = HomeUseCase(repository: homeRepository)
        let homeViewModel = HomeViewModel(usecase: homeUseCase)
        let homeViewController = HomeViewController(homeViewModel)
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}

