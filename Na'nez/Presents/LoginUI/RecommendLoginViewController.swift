//
//  RecommendLoginViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import UIKit
import RxSwift

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
        recommendLoginView.onKakaoLoginClicked = { [weak viewModel] in
            viewModel?.performKakaoLogin()
        }
        
        recommendLoginView.onAnotherLoginClicked = { [weak self] in
            print("onAnotherLoginClicked")
            self?.showAnotherLogin()
        }
        
        recommendLoginView.onStartGuestClicked = { [weak viewModel] in
            viewModel?.startAsGuest()
        }
        
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

}

