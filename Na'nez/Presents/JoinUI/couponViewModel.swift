//
//  CouponViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/8/23.
//

import Foundation
import RxSwift
import RxCocoa

class CouponViewModel {
    private let signUpUseCase: SignUpUseCase
    private let disposeBag = DisposeBag()
    
    let signUpSuccess = PublishSubject<Void>()
    
    init(useCase: SignUpUseCase) {
        self.signUpUseCase = useCase
    }
    
    func signUp(dto: SignUpDTO) {
        signUpUseCase.execute(signUpDTO: dto)
            .subscribe(
                onSuccess: { userInfo in
                    print("회원가입에 성공하였습니다.")
                    self.signUpSuccess.onNext(())
                },
                onFailure: { error in
                    print("회원가입에 실패하였습니다: \(error.localizedDescription)")
                }
            ).disposed(by: disposeBag)
    }
}
