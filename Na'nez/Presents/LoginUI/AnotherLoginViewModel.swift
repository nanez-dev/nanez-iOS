//
//  AnotherLoginViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import RxSwift

class AnotherLoginsViewModel {
    let loginResult: PublishSubject<Bool> = PublishSubject()
    
    func performAppleLogin() {
        print("Apple Login Button Clicked")
    }
    
    func performNaverLogin() {
        print("Naver Login Button Clicked")
    }
    
    func performGoogleLogin() {
        print("Google Login Button Clicked")
    }
    
    func performEmailLogin() {
        print("Email Login Button Clicked")
    }
}
