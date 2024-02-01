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
    let loginResult: PublishSubject<LoginResponse> = PublishSubject()

    // 초기화
    init(useCase: EmailLoginUseCaseProtocol) {
        self.useCase = useCase
    }

    // 로그인 함수
    func login(email: String, password: String) {
        useCase.login(email: email, password: password)
            .subscribe(onNext: { [weak self] response in
//                print("Access Token: \(response.access_token ?? "")")
//                print("Refresh Token: \(response.refresh_token ?? "")")
                TokenManager.shared.saveTokens(accessToken: response.access_token, refreshToken: response.refresh_token)
                self?.loginResult.onNext(response)
            }, onError: { [weak self] error in
                print("Login Error: \(error)")
                self?.loginResult.onError(error)
            }).disposed(by: disposeBag)
    }
}

