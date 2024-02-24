//
//  SurveyViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/6/23.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SurveyViewController: UIViewController {
    private let surveyView = SurveyView()
    let viewModel = SurveyViewModel()
    var sharedViewModel = SharedViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        configure()
        setupBinding()
    }
    
    private func configure() {
        view.addSubview(surveyView)
        surveyView.translatesAutoresizingMaskIntoConstraints = false
        
        surveyView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        surveyView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        for (index, button) in surveyView.buttons.enumerated() {
            button.rx.tap
                .subscribe(onNext: { [weak self] in
                    print("Button ID: \(self?.surveyView.incenseButtonInfo[index].id ?? 0)")

                    self?.viewModel.selectButton(at: index)
                    
                }).disposed(by: disposeBag)
        }
        
        viewModel.isButtonSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSelected in
                self?.surveyView.nextButton.isEnabled = isSelected
                self?.surveyView.nextButton.backgroundColor = isSelected ? SurveyView.mainturquoise : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
            }).disposed(by: disposeBag)
        
        surveyView.skipButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToCouponVC()
            }).disposed(by: disposeBag)
        
        surveyView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToCouponVC()
            }).disposed(by: disposeBag)
    }

    private func navigateToCouponVC() {
        let signUpRp = SignUpRepository(signUpService: SignUpService())
        let signUpUC = SignUpUseCase(repository: signUpRp)
        let couponVM = CouponViewModel(useCase: signUpUC)
        let couponVC = CouponViewController(couponViewModel: couponVM, surveyViewModel: viewModel, sharedViewModel: self.sharedViewModel)
        couponVC.sharedViewModel = self.sharedViewModel
        couponVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        couponVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(couponVC, animated: true)
    }
}

