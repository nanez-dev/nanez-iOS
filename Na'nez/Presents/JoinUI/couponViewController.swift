//
//  CouponViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/8/23.
//

import UIKit
import SnapKit
import Then
import RxSwift

class CouponViewController: UIViewController {
    private let couponView = CouponView()
    private let couponViewModel: CouponViewModel
    private let disposeBag = DisposeBag()

    init(couponViewModel: CouponViewModel) {
        self.couponViewModel = couponViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        configure()
        setupBinding()
    }
    
    private func configure() {
        view.addSubview(couponView)
        couponView.translatesAutoresizingMaskIntoConstraints = false
        
        couponView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        couponView.backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        couponView.codeTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                let isEmpty = text.isEmpty
                let color = isEmpty ? #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1) : NicknameView.mainturquoise
                self?.couponView.checkButton.backgroundColor = color
                self?.couponView.checkButton.isEnabled = !isEmpty
                
                self?.couponView.canMatchLabel.isHidden = true
            }).disposed(by: disposeBag)
    }
    
    private func showSameAlert() {
        let alertView = CustomAlertView()
        alertView.configure(message: "확인이 완료되었습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func showInconsistencyAlert() {
        let alertView = CustomAlertView()
//        alertView.messageLabel.textColor = .red
        alertView.configure(message: "일치하는 쿠폰 코드가 없습니다.", actionButtonTitle: "확인")
        alertView.onActionButotnTapped = {
            alertView.dismiss()
        }
        alertView.show(on: self.view)
    }
    
    private func handleCouponValidation(isValid: Bool) {
        if isValid {
            print("쿠폰이 등록되었습니다.")
            self.couponView.codeTextField.layer.borderColor = #colorLiteral(red: 0.2625362277, green: 0.6258890629, blue: 0.9609254003, alpha: 1)
            self.couponView.codeTextField.layer.borderWidth = 1
            self.couponView.nextButton.isEnabled = true
            self.couponView.nextButton.backgroundColor = CouponView.mainturquoise
        }
        else {
            print("사용 불가능한 쿠폰입니다.")
            self.couponView.codeTextField.layer.borderColor = UIColor.red.cgColor
            self.couponView.codeTextField.layer.borderWidth = 1
            self.couponView.nextButton.isEnabled = false
            self.couponView.nextButton.backgroundColor = #colorLiteral(red: 0.8588235378, green: 0.8588235378, blue: 0.8588235378, alpha: 1)
        }
    }
}

