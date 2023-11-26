//
//  TermsCondition.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/24/23.
//

import Foundation

struct TermsCondition {
    let id: Int
    let title: String
    let content: String
    let isMandatory: Bool
    var isAgreed: Bool
    
    mutating func setAgreement(_ isAgreed: Bool) {
        self.isAgreed = isAgreed
    }
}
