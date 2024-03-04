//
//  ChangePwUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/21/24.
//

import Foundation
import RxSwift

final class ChangePwUseCase {
    private let repository: ChangePwRepositoryProtocol
    
    init(repository: ChangePwRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(currentPassword: String, newPassword: String) -> Observable<Bool> {
        return repository.changePassword(currentPassword: currentPassword, newPassword: newPassword)
    }
}
