//
//  NicknameViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/5/23.
//

import Foundation
import RxSwift
import RxCocoa

class NicknameViewModel {
    private let disposeBag = DisposeBag()
    
    let nickname = BehaviorSubject<String>(value: "")
    
    // Input
    let checkNickname = PublishSubject<String>()
    
    // Output
    let nicknameValidated: Observable<Bool>
    
    init(useCase: NicknameUseCase) {
        nicknameValidated = checkNickname
            .flatMapLatest { nickname in
                useCase.verifyNickname(nickname: nickname)
                    .catchErrorJustReturn(false)
            }
            .share(replay: 1)
        
        checkNickname
            .subscribe(onNext: { nickname in
                print("검층 요청된 닉네임: \(nickname)")
            }).disposed(by: disposeBag)
    }
    
}
