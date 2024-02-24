//
//  ResignUserUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/21/24.
//

import Foundation
import RxSwift

final class ResignUserUseCase {
    private let repository: ResignUserRepositoryProtocol
    
    init(repository: ResignUserRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> Observable<Void> {
        return repository.resignUser()
    }
}
