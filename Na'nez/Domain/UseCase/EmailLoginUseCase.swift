//
//  EmailLoginUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift

protocol EmailLoginUseCaseProtocol {
    func login(email: String, password: String) -> Observable<Bool>
}

class EmailLoginUseCase: EmailLoginUseCaseProtocol {
    private let repository: EmailLoginRepositoryProtocol

    init(repository: EmailLoginRepositoryProtocol) {
        self.repository = repository
    }

    func login(email: String, password: String) -> Observable<Bool> {
        return repository.login(email: email, password: password)
            .map { response in
                // 비즈니스 로직 처리
                // 예: 성공 여부에 따라 다른 처리를 할 수 있음
                return !response.access_token.isEmpty
            }
    }
}
