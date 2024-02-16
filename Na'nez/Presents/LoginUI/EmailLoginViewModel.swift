//
//  EmailLoginViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift
import RxCocoa

class EmailLoginViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    let useCase: EmailLoginUseCaseProtocol
    
    struct Input {
        let loginCredentials: Observable<(email: String, password: String)>
    }
    
    struct Output {
        let loginResult: Observable<LoginResponse>
        let loginError: Observable<Error>
    }
    
    func transform(input: Input) -> Output {
        let resultSubject = PublishSubject<LoginResponse>()
        let errorSubject = PublishSubject<Error>()
        
        input.loginCredentials
            .flatMapLatest { [weak self] email, password -> Observable<LoginResponse> in
                guard let self = self else { return .empty() }
                return self.useCase.login(email: email, password: password)
                    .catch { error -> Observable<LoginResponse> in
                        errorSubject.onNext(error)
                        return .empty()
                    }
            }
            .subscribe(onNext: { response in
                TokenManager.shared.saveTokens(accessToken: response.access_token, refreshToken: response.refresh_token)
                resultSubject.onNext(response)
            }).disposed(by: disposeBag)
        
        return Output(loginResult: resultSubject.asObservable(), loginError: errorSubject.asObservable())
    }

    init(useCase: EmailLoginUseCaseProtocol) {
        self.useCase = useCase
    }
}

