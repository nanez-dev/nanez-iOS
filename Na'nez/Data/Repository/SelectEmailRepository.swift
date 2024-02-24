//
//  SelectEmailRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import Foundation
import RxSwift

final class SelectEmailRepository {
    private let emailSendService: EmailSendService
    private let emailVerifyService: EmailVerifyService

    init(emailSendService: EmailSendService, emailVerifyService: EmailVerifyService) {
        self.emailSendService = emailSendService
        self.emailVerifyService = emailVerifyService
    }
    
    func postEmailSend(email: String) -> Observable<Bool> {
        return emailSendService.postEmailSend(email: email)
    }
    
    func verifyEmailCode(email: String, code: Int) -> Observable<Bool> {
        return emailVerifyService.postEmailVerify(withCode: code, email: email)
    }
}

