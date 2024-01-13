//
//  FindPwRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/13/24.
//

import Foundation
import RxSwift

protocol FindPwRepositoryProtocol {
    func postFindPw(email: String) -> Observable<Bool>
}

final class FindPwRepository: FindPwRepositoryProtocol {
    private let service: FindPwService
    
    init(service: FindPwService) {
        self.service = service
    }
    
    func postFindPw(email: String) -> Observable<Bool> {
        return service.postFindPw(email: email)
    }
}
