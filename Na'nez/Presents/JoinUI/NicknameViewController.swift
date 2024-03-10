//
//  NicknameViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/5/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class NicknameViewController: UIViewController {
    private let nicknameView = NicknameView()
    private let viewModel: NicknameViewModel
    var sharedViewModel: SharedViewModel!
    private let disposeBag = DisposeBag()
            
    var nicknameObservable: Observable<String> {
        return nicknameView.nickTextField.rx.text.orEmpty.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        configure()
        setupBinding()
    }
    
    init(viewModel: NicknameViewModel, sharedViewModel: SharedViewModel) {
        self.viewModel = viewModel
        self.sharedViewModel = sharedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        view.addSubview(nicknameView)
        nicknameView.translatesAutoresizingMaskIntoConstraints = false
        
        nicknameView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        nicknameView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        nicknameView.nickTextField.rx.text.orEmpty
            .bind(to: viewModel.nickname)
            .disposed(by: disposeBag)
        
        nicknameView.nickTextField.rx.text.orEmpty
            .bind(to: sharedViewModel.nicknameRelay)
            .disposed(by: disposeBag)
        
        nicknameView.nickTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                let isEmpty = text.isEmpty
                let color = isEmpty ? #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1) : NicknameView.mainturquoise
                self?.nicknameView.checkButton.backgroundColor = color
                self?.nicknameView.checkButton.isEnabled = !isEmpty

                self?.nicknameView.nextButton.isEnabled = false
                self?.nicknameView.nextButton.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)

                self?.nicknameView.canMatchLabel.isHidden = true
                self?.nicknameView.notMatchLabel.isHidden = true
            }).disposed(by: disposeBag)
        
        nicknameView.checkButton.rx.tap
            .withLatestFrom(nicknameObservable)
            .bind(to: viewModel.checkNickname)
            .disposed(by: disposeBag)
        
        nicknameView.checkButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.3) {
                    self.nicknameView.checkButtonVerticalConstraint?.update(offset: 40)
                    self.view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
        
        nicknameView.nextButton.rx.tap
            .withLatestFrom(nicknameObservable)
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToSurveyVC()
            }).disposed(by: disposeBag)

        viewModel.nicknameValidated
            .subscribe(onNext: { [weak self] isValid in
                self?.handleNicknameValidation(isValid: isValid)
                self?.nicknameView.canMatchLabel.isHidden = !isValid
                self?.nicknameView.notMatchLabel.isHidden = isValid
            }).disposed(by: disposeBag)
    }
    
    func navigateToSurveyVC() {
        let surveyVC = SurveyViewController()
        surveyVC.sharedViewModel = self.sharedViewModel
        surveyVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        surveyVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(surveyVC, animated: true)
    }
    
    private func handleNicknameValidation(isValid: Bool) {
        if isValid {
            print("사용 가능한 닉네임입니다.")
            self.nicknameView.nickTextField.layer.borderColor = #colorLiteral(red: 0.2625362277, green: 0.6258890629, blue: 0.9609254003, alpha: 1)
            self.nicknameView.nickTextField.layer.borderWidth = 1
            self.nicknameView.nextButton.isEnabled = true
            self.nicknameView.nextButton.backgroundColor = NicknameView.mainturquoise
        }
        else {
            print("사용 불가능한 닉네임입니다.")
            self.nicknameView.nickTextField.layer.borderColor = UIColor.red.cgColor
            self.nicknameView.nickTextField.layer.borderWidth = 1
            self.nicknameView.nextButton.isEnabled = false
            self.nicknameView.nextButton.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        }
    }
}
