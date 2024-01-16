//
//  FindPwUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/13/24.
//

import Foundation
import RxSwift

class FindPwUseCase {
    private let repository: FindPwRepositoryProtocol
    
    init(repository: FindPwRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(email: String) -> Observable<Bool> {
        return repository.postFindPw(email: email)
    }
}
