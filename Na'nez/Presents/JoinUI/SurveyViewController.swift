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

class SurveyViewController: UIViewController {
    private let surveyView = SurveyView()
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
    }
}
