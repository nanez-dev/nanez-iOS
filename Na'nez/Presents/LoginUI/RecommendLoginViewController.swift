//
//  RecommendLoginViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import RxSwift
import RxCocoa

class RecommendLoginViewController: UIViewController {
    private let recommendLoginView = RecommendLoginView(frame: .zero)
    private var viewModel = RecommendLoginViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout() {
        view.addSubview(recommendLoginView)
        recommendLoginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        recommendLoginView.startGuestButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.showHome()
            })
        
        viewModel.loginResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isSuccess in
                if isSuccess {
                    print("성공")
                }
                else {
                    print("실패")
                }
            }).disposed(by: disposeBag)
    }
    
    private func showAnotherLogin() {
        let anotherLoginVC = AnotherLoginViewController()
        navigationController?.pushViewController(anotherLoginVC, animated: true)
    }

    private func showHome() {
        let homeVC = TabController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

