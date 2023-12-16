//
//  SignUpRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/16/23.
//

import Foundation
import RxSwift

protocol SignUpRepositoryProtocol {
    func signUp(with dto: SignUpDTO) -> Single<UserInfo>
}

final class SignUpRepository: SignUpRepositoryProtocol {
    private let signUpService: SignUpService
    
    init(signUpService: SignUpService) {
        self.signUpService = signUpService
    }
    
    func signUp(with dto: SignUpDTO) -> Single<UserInfo> {
        return signUpService.postSignUp(signUpDTO: dto)
    }
}
