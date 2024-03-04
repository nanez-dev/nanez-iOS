//
//  ChangePwViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/27/24.
//

import Foundation
import RxSwift
import RxCocoa

class ChangePwViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    private let useCase: ChangePwUseCase
    
    struct Input {
        let currentPassword: Observable<String>
        let newPassword: Observable<String>
        let submitTrigger: Observable<Void>
    }
    
    struct Output {
        let result: Observable<Bool>
    }
    
    init(disposeBag: DisposeBag, useCase: ChangePwUseCase) {
        self.disposeBag = disposeBag
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let result = input.submitTrigger
            .withLatestFrom(Observable.combineLatest(input.currentPassword, input.newPassword))
            .flatMapLatest { [unowned self] currentPassword, newPassword in
                return self.useCase.execute(currentPassword: currentPassword, newPassword: newPassword)
                    .catchAndReturn(false)
            }
        return Output(result: result)
    }
}
