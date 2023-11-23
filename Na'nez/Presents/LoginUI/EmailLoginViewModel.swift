//
//  EmailLoginViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift
import RxCocoa

class EmailLoginViewModel {
    // 의존성
    private let useCase: EmailLoginUseCaseProtocol
    private let disposeBag = DisposeBag()

    // RxSwift Subjects
    let loginResult: PublishSubject<Bool> = PublishSubject()

    // 초기화
    init(useCase: EmailLoginUseCaseProtocol) {
        self.useCase = useCase
    }

    // 로그인 함수
    func login(email: String, password: String) {
        useCase.login(email: email, password: password)
            .subscribe(onNext: { [weak self] isSuccess in
                self?.loginResult.onNext(isSuccess)
            }, onError: { [weak self] error in
                print("Login Error: \(error)")
                self?.loginResult.onNext(false)
            }).disposed(by: disposeBag)
    }
}
