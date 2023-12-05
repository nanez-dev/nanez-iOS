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
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        configure()
        setupBinding()
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
    }
}
