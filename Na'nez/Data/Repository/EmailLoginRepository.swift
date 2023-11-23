//
//  EmailLoginRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift

protocol EmailLoginRepositoryProtocol {
    func login(email: String, password: String) -> Observable<LoginResponse>
}

class EmailLoginRepository: EmailLoginRepositoryProtocol {
    private let loginService: LoginService

    init(loginService: LoginService) {
        self.loginService = loginService
    }

    func login(email: String, password: String) -> Observable<LoginResponse> {
        return loginService.postLogin(email: email, Pw: password)
    }
}
