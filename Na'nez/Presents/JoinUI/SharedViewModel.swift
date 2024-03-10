//
//  SharedViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/23/24.
//

import Foundation
import RxSwift
import RxCocoa

class SharedViewModel {
    let emailRelay = BehaviorRelay<String?>(value: nil)
    let passwordRelay = BehaviorRelay<String?>(value: nil)
    let nicknameRelay = BehaviorRelay<String?>(value: nil)
}
