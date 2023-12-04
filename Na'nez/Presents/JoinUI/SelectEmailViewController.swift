//
//  SelectEmailViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SelectEmailViewController: UIViewController {
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let selectEmailView = SelectEmailView()
    private let viewModel: SelectEmailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: SelectEmailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        setupBinding()
        configureLoadingIndicator()
    }
    
    private func configureLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.center = view.center
        loadingIndicator.hidesWhenStopped = true
    }
    
    private func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }

    private func configure() {
        view.addSubview(selectEmailView)
        selectEmailView.translatesAutoresizingMaskIntoConstraints = false
        
        selectEmailView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        selectEmailView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        selectEmailView.emailAuthButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self, let email = self.selectEmailView.emailTextField.text, !email.isEmpty else {
                    self?.showEmptyEmail()
                    return
                }
                
                if !self.isEmailValid(email) {
                    self.showEmailFormatAlert()
                    return
                }
                
                self.showLoadingIndicator()
                
                self.viewModel.sendEmail(email: email)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { success in
                        self.hideLoadingIndicator()
                        if success {
                            self.viewModel.startCountdown(duration: 180)
                            self.selectEmailView.updateEmailAuthButtonState(isEnabled: false)
                            print("Success")
                        }
                        else {
                            print("Failure")
                            self.showFailureAlert()
                        }
                    }, onError: { error in
                        print("Error")
                    }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        selectEmailView.resendButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self, let email = self.selectEmailView.emailTextField.text, !email.isEmpty else {
                    self?.showEmptyEmail()
                    return
                }
                
                if !self.isEmailValid(email) {
                    self.showEmailFormatAlert()
                    return
                }
                
                self.showLoadingIndicator()
                
                self.viewModel.sendEmail(email: email)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { success in
                        self.hideLoadingIndicator()
                        if success {
                            self.viewModel.startCountdown(duration: 180)
                            print("Success2")
                        }
                        else {
                            print("Failure2")
                            self.showFailureAlert()
                        }
                    }, onError: { error in
                        print("Error2")
                    }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        selectEmailView.authNumberTextField.rx.text.orEmpty
            .filter { $0.count == 6 }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] codeString in
                guard let self = self, let email = self.selectEmailView.emailTextField.text, !email.isEmpty,
                      let code = Int(codeString) else { return }
                self.viewModel.verifyEmailCode(email: email, code: code)
            }).disposed(by: disposeBag)
        
        selectEmailView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToPasswordViewController()
            }).disposed(by: disposeBag)
        
        viewModel.emailVerificationResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                self?.updateNextButtonState(isEnabled: isSuccess)
                if isSuccess {
                    self?.showSuccessCode()
                }
                else {
                    self?.showfailureCode()
                }
            }).disposed(by: disposeBag)
        
        viewModel.isAuthSent
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] success in
                self?.selectEmailView.authNumberTextField.isHidden = !success
                self?.selectEmailView.resendButton.isHidden = !success
                self?.selectEmailView.updateEmailAuthButtonPosition(isAuthVisible: success)
            }).disposed(by: disposeBag)
        
        viewModel.countdownTimer
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] formattedTime in
                guard let self = self else { return }
                if let time = formattedTime {
                    self.selectEmailView.countdownLabel.text = time
                }
                else {
                    self.selectEmailView.authNumberTextField.placeholder = "인증번호 입력"
                }
            }).disposed(by: disposeBag)
        
        viewModel.countdownFinished
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.showResendAlert()
            }).disposed(by: disposeBag)
    }
    
    private func navigateToPasswordViewController() {
        let passwordVC = PasswordViewController()
        passwordVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        passwordVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(passwordVC, animated: true, completion: nil)
    }
    
    private func updateNextButtonState(isEnabled: Bool) {
        selectEmailView.nextButton.isEnabled = isEnabled
        selectEmailView.nextButton.backgroundColor = isEnabled ? .mainturquoise : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
    }
    
    private func showFailureAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "이미 가입이 완료된 이메일입니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }

    private func showEmailFormatAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "이메일 형식이 아닙니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func showResendAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "인증번호 전송을 다시해주세요.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func showEmptyEmail() {
        let alertView = CustomAlertView()
        alertView.configure(message: "이메일을 입력해주세요.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func showSuccessCode() {
        let alertView = CustomAlertView()
        alertView.configure(message: "확인이 완료되었습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func showfailureCode() {
        let alertView = CustomAlertView()
        alertView.configure(message: "인증코드가 틀렸습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
