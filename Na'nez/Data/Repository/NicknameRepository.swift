//
//  NicknameRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/6/23.
//

import Foundation
import RxSwift

class NicknameRepository {
    private let nicknameVerifyService: NicknameVerifyService
    
    init(nicknameVerifyService: NicknameVerifyService) {
        self.nicknameVerifyService = nicknameVerifyService
    }
    
    func postNicknameVerify(nickname: String) -> Observable<Bool> {
        return nicknameVerifyService.postNicknameVerify(nickname: nickname)
    }
}
