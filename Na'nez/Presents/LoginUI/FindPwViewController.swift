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
        view.backgroundColor = .white
        navigationItem.title = "비밀번호 찾기"
        
        viewModel = FindPwViewModel(useCase: FindPwUseCase(repository: FindPwRepository(service: FindPwService())))
        
        configure()
        setupBinding()
        configureCustomIndicatorView()
    }
    
    private func configure() {
        view?.addSubview(findPwView)
        findPwView.translatesAutoresizingMaskIntoConstraints = false
        
        findPwView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func configureCustomIndicatorView() {
        view.addSubview(customIndicatorView)
        customIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        customIndicatorView.isHidden = true
    }
    
    private func setupBinding() {
        findPwView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        findPwView.emailTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                let isEmpty = text.isEmpty
                let color = isEmpty ? #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1) : FindPwView.mainturquoise
                self?.findPwView.emailSendButton.backgroundColor = color
                self?.findPwView.emailSendButton.isEnabled = !isEmpty
                
            }).disposed(by: disposeBag)
        
        findPwView.emailSendButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let email = self?.findPwView.emailTextField.text, !email.isEmpty else { return }
                self?.customIndicatorView.isHidden = false
                self?.customIndicatorView.startAnimating()
                self?.viewModel.postFindPw(email: email)
            }).disposed(by: disposeBag)
        
        viewModel.postFindPwSuccess
            .subscribe(onNext: { [weak self] success in
                self?.customIndicatorView.stopAnimating()
                if success {
                    self?.findPwView.emailSendButton.isEnabled = false
                    self?.findPwView.emailSendButton.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
                    self?.successAlert()
                }
                else {
                    self?.errorAlert(message: "사용자를 찾을 수 없습니다.")
                }
            }, onError: { [weak self] _ in
                self?.customIndicatorView.stopAnimating()
                self?.customIndicatorView.isHidden = true
            }).disposed(by: disposeBag)
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
