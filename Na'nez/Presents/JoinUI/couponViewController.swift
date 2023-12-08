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
    private let disposeBag = DisposeBag()
    
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
    }
}
