//
//  SelectEmailUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import Foundation
import RxSwift

class SelectEmailUseCase {
    private let repository: SelectEmailRepository
    
    init(repository: SelectEmailRepository) {
        self.repository = repository
    }
    
    func sendEmail(email: String) -> Observable<Bool> {
        return repository.postEmailSend(email: email)
    }

    func verifyEmailCode(email: String, code: Int) -> Observable<Bool> {
        return repository.verifyEmailCode(email: email, code: code)
    }
}

