//
//  PasswordViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/3/23.
//

import Foundation
import RxSwift

class PasswordViewModel {
    let passwordValidity = PublishSubject<Bool>()
    let passwordMatch = PublishSubject<Bool>()
    private let disposeBag = DisposeBag()
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func checkPassword(password: String, confirmedPassword: String) {
        let isValid = validatePassword(password)
        let isMatch = isValid && (password == confirmedPassword)
        passwordValidity.onNext(isValid)
        passwordMatch.onNext(isMatch)
    }
}
