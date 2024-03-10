//
//  NicknameUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/6/23.
//

import Foundation
import RxSwift

final class NicknameUseCase {
    private let repository: NicknameRepository
    
    init(repository: NicknameRepository) {
        self.repository = repository
    }
    
    func verifyNickname(nickname: String) -> Observable<Bool> {
        return repository.postNicknameVerify(nickname: nickname)
    }
}
