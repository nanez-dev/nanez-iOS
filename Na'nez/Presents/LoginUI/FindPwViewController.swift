//
//  FindPwViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/13/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class FindPwViewController: UIViewController {
    private let customIndicatorView = CustomIndicatorView()
    private let findPwView = FindPwView()
    private let disposeBag = DisposeBag()
    private var viewModel: FindPwViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "비밀번호 찾기"
        setupFindPwView()
        setupCustomIndicatorView()
    }
    
    private func setupFindPwView() {
        view.addSubview(findPwView)
        findPwView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupCustomIndicatorView() {
        view.addSubview(customIndicatorView)
        customIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        customIndicatorView.isHidden = true
    }
    
    private func setupViewModel() {
        let useCase = FindPwUseCase(repository: FindPwRepository(service: FindPwService()))
        viewModel = FindPwViewModel(useCase: useCase)
    }
    
    private func bindViewModel() {
        bindEmailTextField()
        
        findPwView.emailSendButton.rx.tap
            .withLatestFrom(findPwView.emailTextField.rx.text.orEmpty)
            .filter { !$0.isEmpty }
            .flatMapLatest { [unowned self] email in
                self.viewModel.sendEmail(email: email)
                    .do(onSubscribe: { self.customIndicatorView.isHidden = false; self.customIndicatorView.startAnimating() })
                    .observe(on: MainScheduler.instance)
                    .catchAndReturn(false)
            }
            .subscribe(onNext: { [weak self] success in
                self?.customIndicatorView.isHidden = true
                self?.customIndicatorView.stopAnimating()
                if success {
                    self?.successAlert()
                }
                else {
                    self?.errorAlert(message: "사용자를 찾을 수 없습니다.")
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindEmailTextField() {
        findPwView.emailTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .bind(to: findPwView.emailSendButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        findPwView.emailTextField.rx.text.orEmpty
            .map { $0.isEmpty ? #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1) : FindPwView.mainturquoise}
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] color in
                self?.findPwView.emailSendButton.backgroundColor = color
            }).disposed(by: disposeBag)
    }
    
    private func bindPostFindPwSuccess(output: FindPwViewModel.Output) {
        output.findPwResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] success in
                self?.updateUIOnResult(success: success)
            }).disposed(by: disposeBag)
    }
    
    private func updateUIOnResult(success: Bool) {
        customIndicatorView.stopAnimating()
        customIndicatorView.isHidden = true
        if success {
            successAlert()
        }
        else {
            errorAlert(message: "사용자를 찾을 수 없습니다.")
        }
    }
    
    private func successAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "이메일 전송이 완료되었습니다. 로그인 화면으로 이동하시겠습니까?", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
            self.dismiss(animated: true, completion: nil)
        }
        alertView.show(on: self.view)
    }
    
    private func errorAlert(message: String) {
        let alertView = CustomAlertView()
        alertView.configure(message: message, actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
}
