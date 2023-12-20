//
//  CouponRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/11/23.
//

import Foundation
import RxSwift

protocol CouponRepositoryProtocol {
    func signUp(with dto: SignUpDTO) -> Single<UserInfo>
}

class CouponRepository: CouponRepositoryProtocol {
    private let signUpService: SignUpService
    
    init(signUpService: SignUpService) {
        self.signUpService = signUpService
    }
    
    func signUp(with dto: SignUpDTO) -> Single<UserInfo> {
        return signUpService.postSignUp(signUpDTO: dto)
    }
}
