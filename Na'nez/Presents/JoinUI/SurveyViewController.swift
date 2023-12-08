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
    private let viewModel = SurveyViewModel()
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
                    self?.viewModel.selectButton(at: index)
                }).disposed(by: disposeBag)
        }
        
        viewModel.selectedButton
            .subscribe(onNext: { [weak self] selectedIndex in
                self?.updateButtonSelectionState(selectedIndex: selectedIndex)
            }).disposed(by: disposeBag)
        
        viewModel.isButtonSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSelected in
                self?.surveyView.nextButton.isEnabled = isSelected
                self?.surveyView.nextButton.backgroundColor = isSelected ? SurveyView.mainturquoise : #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
            }).disposed(by: disposeBag)
        
        surveyView.nextButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let couponVC = CouponViewController()
                couponVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                couponVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self?.present(couponVC, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func updateButtonSelectionState(selectedIndex: Int?) {
        for (index, button) in surveyView.buttons.enumerated() {
            button.isSelected = index == selectedIndex
        }
    }
}
