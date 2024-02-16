//
//  AnotherLoginViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift

class AnotherLoginViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    let loginResult: PublishSubject<Bool> = PublishSubject()
    
    struct Input {
        let loginTrigger: Observable<Void>
    }
    
    struct Output {
        let loginSuccess: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        input.loginTrigger
            .subscribe(onNext: { [weak self] _ in
                self?.loginResult.onNext(true)
            }).disposed(by: disposeBag)
        
        return Output(loginSuccess: loginResult.asObservable())
    }
}
