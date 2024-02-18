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
        setupUI()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(emailLoginView)
        view.addSubview(customIndicatorView)
        customIndicatorView.isHidden = true
    }
    
    private func setupConstraints() {
        emailLoginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        customIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let input = EmailLoginViewModel.Input(
            loginCredentials: emailLoginView.loginButton.rx.tap
                .withLatestFrom(Observable.combineLatest(emailLoginView.emailField.rx.text.orEmpty, emailLoginView.pwField.rx.text.orEmpty))
                .map { ($0, $1) }
        )
        
        let output = viewModel.transform(input: input)
        
        bindActions()
        bindOutputs(output)
    }
    
    private func bindActions() {
        emailLoginView.backButton.rx.tap
            .bind { [weak self] in self?.navigationController?.popViewController(animated: true) }
            .disposed(by: disposeBag)
        
        emailLoginView.pwFindButton.rx.tap
            .bind { [weak self] in self?.showFindPwView() }
            .disposed(by: disposeBag)
    }
    
    private func bindOutputs(_ output: EmailLoginViewModel.Output) {
        output.loginResult
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in self?.handleLoginSuccess() }
            .disposed(by: disposeBag)
        
        output.loginError
            .observe(on: MainScheduler.instance)
            .bind { [weak self] _ in self?.handleLoginFailure() }
            .disposed(by: disposeBag)
    }
    
    private func handleLoginSuccess() {
        customIndicatorView.stopAnimating()
        customIndicatorView.isHidden = true
        showHomeView()
    }
    
    private func handleLoginFailure() {
        customIndicatorView.stopAnimating()
        customIndicatorView.isHidden = true
        emailLoginView.indicateLoginFailure()
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
        let tabController = TabController()
        UIApplication.shared.keyWindow?.rootViewController = tabController
    }
}

