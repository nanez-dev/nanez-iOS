//
//  CouponUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/11/23.
//

import Foundation
import RxSwift

class CouponUseCase {
    private let repository: CouponRepositoryProtocol
    
    init(repository: CouponRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeSignUp(dto: SignUpDTO) -> Single<UserInfo> {
        return repository.signUp(with: dto)
    }
}
