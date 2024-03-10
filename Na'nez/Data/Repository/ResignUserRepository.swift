//
//  ResignUserRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/21/24.
//

import Foundation
import RxSwift

protocol ResignUserRepositoryProtocol {
    func resignUser() -> Observable<Void>
}

final class ResignUserRepository: ResignUserRepositoryProtocol {
    private let service: ResignUserService
    
    init(service: ResignUserService) {
        self.service = service
    }
    
    func resignUser() -> Observable<Void> {
        return service.deleteResignUser()
    }
}
