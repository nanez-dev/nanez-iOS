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
    private let couponUseCase: CouponUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: CouponUseCase) {
        self.couponUseCase = useCase
    }
    
    func signUp(dto: SignUpDTO) {
        couponUseCase.executeSignUp(dto: dto)
            .subscribe(
                onSuccess: { userInfo in
                    print("회원가입에 성공하였습니다.")
                },
                onFailure: { error in
                    print("회원가입에 실패하였습니다: \(error.localizedDescription)")
                }
            ).disposed(by: disposeBag)
    }
    
}
