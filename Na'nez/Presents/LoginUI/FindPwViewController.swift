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
    private let findPwView = FindPwView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "비밀번호 찾기"
        
        configure()
        setupBinding()
    }
    
    private func configure() {
        view?.addSubview(findPwView)
        findPwView.translatesAutoresizingMaskIntoConstraints = false
        
        findPwView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
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
    }
    
    private func successAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "이메일 전송이 완료되었습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
}
