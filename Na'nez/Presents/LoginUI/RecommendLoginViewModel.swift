//
//  RecommendLoginViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift

class RecommendLoginViewModel {
    let loginResult: PublishSubject<Bool> = PublishSubject()

    func performKakaoLogin() {
        loginResult.onNext(true)
    }

    func performAnotherLogin() {
        loginResult.onNext(false)
    }

    func startAsGuest() {
        loginResult.onNext(true)
    }
}
