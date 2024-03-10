//
//  SettingViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/19/24.
//

import Foundation
import RxSwift
import RxCocoa

class SettingViewModel {
    struct Input {
        let resignTap: Observable<Void>
    }
    
    struct Output {
        let resignCompleted: Observable<Void>
        let resignFailed: Observable<Error>
    }
    
    private let useCase: ResignUserUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: ResignUserUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let errorTracker = PublishSubject<Error>()
        let resignCompleted = input.resignTap
            .flatMapLatest { [unowned self] _ -> Observable<Void> in
                self.useCase.execute()
                    .catch { error in
                        errorTracker.onNext(error)
                        return Observable.empty()
                    }
            }
        
        return Output(resignCompleted: resignCompleted, resignFailed: errorTracker.asObservable())
    }
}
