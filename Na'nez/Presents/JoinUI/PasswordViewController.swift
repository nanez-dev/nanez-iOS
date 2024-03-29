//
//  PasswordViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/3/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class PasswordViewController: UIViewController {
    private let passwordView = PasswordView()
    private let disposeBag = DisposeBag()
    var sharedViewModel = SharedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        configure()
        setupBinding()
    }
    
    init(sharedViewModel: SharedViewModel = SharedViewModel()) {
        self.sharedViewModel = sharedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        view.addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        let viewModel = PasswordViewModel()
        
        passwordView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        passwordView.checkPwTextField.rx.text.orEmpty
            .bind(to: sharedViewModel.passwordRelay)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            passwordView.pwTextField.rx.text.orEmpty.distinctUntilChanged(),
            passwordView.checkPwTextField.rx.text.orEmpty.distinctUntilChanged()
        )
        .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
        .subscribe(onNext: { [weak self] password, confirmPassword in
            let isValid = viewModel.validatePassword(password)
            let isMatch = password == confirmPassword
            self?.passwordView.updateValidationState(isValid: isValid, isMatch: isMatch)
            self?.passwordView.nextButton.isEnabled = isValid && isMatch
            self?.passwordView.nextButton.backgroundColor = isValid && isMatch ? .mainturquoise : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        }).disposed(by: disposeBag)
        
        passwordView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToNicknameVC()
            }).disposed(by: disposeBag)
    }
    
    private func navigateToNicknameVC() {
        let nicknameRepository = NicknameRepository(nicknameVerifyService: NicknameVerifyService())
        let nicknameUseCase = NicknameUseCase(repository: nicknameRepository)
        let viewModel = NicknameViewModel(useCase: nicknameUseCase)
        let nicknameVC = NicknameViewController(viewModel: viewModel, sharedViewModel: self.sharedViewModel)
        nicknameVC.sharedViewModel = self.sharedViewModel
        nicknameVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        nicknameVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(nicknameVC, animated: true)
    }
}
