//
//  EmailLoginUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift

protocol EmailLoginUseCaseProtocol {
    func login(email: String, password: String) -> Observable<LoginResponse>
}

final class EmailLoginUseCase: EmailLoginUseCaseProtocol {
    private let repository: EmailLoginRepositoryProtocol

    init(repository: EmailLoginRepositoryProtocol) {
        self.repository = repository
    }

    func login(email: String, password: String) -> Observable<LoginResponse> {
        return repository.login(email: email, password: password)
    }
}

