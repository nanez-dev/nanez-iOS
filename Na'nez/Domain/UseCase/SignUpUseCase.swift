//
//  SignUpUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/16/23.
//

import Foundation
import RxSwift

class SignUpUseCase {
    private let repository: SignUpRepositoryProtocol
    
    init(repository: SignUpRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(signUpDTO: SignUpDTO) -> Single<UserInfo> {
        return repository.signUp(with: signUpDTO)
    }
}
