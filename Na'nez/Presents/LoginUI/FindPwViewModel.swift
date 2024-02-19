//
//  FindPwViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/13/23.
//

import Foundation
import RxSwift
import RxCocoa

class FindPwViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    let useCase: FindPwUseCase
    
    struct Input {
        let email: Observable<String>
    }
    
    struct Output {
        let findPwResult: Observable<Bool>
    }
    
    func sendEmail(email: String) -> Observable<Bool> {
        return useCase.execute(email: email)
            .catchAndReturn(false)
    }
    
    func transform(input: Input) -> Output {
        let findPwResult = PublishSubject<Bool>()
        
        input.email
            .flatMapLatest { [weak self] email -> Observable<Bool> in
                guard let self = self else { return .empty() }
                return self.useCase.execute(email: email)
                    .catch { error -> Observable<Bool> in
                        if let error = error as NSError?, error.domain == "UserNotFoundError" {
                            return .just(false)
                        }
                        else {
                            print("Error: \(error.localizedDescription)")
                            return .just(false)
                        }
                    }
            }
            .bind(to: findPwResult)
            .disposed(by: disposeBag)
        
        return Output(findPwResult: findPwResult.asObservable())
    }
    
    init(useCase: FindPwUseCase) {
        self.useCase = useCase
    }
}
