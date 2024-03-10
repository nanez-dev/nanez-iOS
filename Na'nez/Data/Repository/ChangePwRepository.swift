//
//  ChangePwRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/21/24.
//

import Foundation
import RxSwift

protocol ChangePwRepositoryProtocol {
    func changePassword(currentPassword: String, newPassword: String) -> Observable<Bool>
}

final class ChangePwRepository: ChangePwRepositoryProtocol {
    private let service: ChangePwService
    
    init(service: ChangePwService) {
        self.service = service
    }
    
    func changePassword(currentPassword: String, newPassword: String) -> Observable<Bool> {
        return service.patchChangePw(currentPassword: currentPassword, newPassword: newPassword)
    }
}
