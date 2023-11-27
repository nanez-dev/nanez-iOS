//
//  TermsRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/24/23.
//

import Foundation
import RxSwift

class TermsRepository: TermsRepositoryeProtocol {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func saveTermsAgreement(_ termsAgreement: TermsAgreement) {
        defaults.set(termsAgreement.isServiceTermsAgreed, forKey: "isServiceTermsAgreed")
        defaults.set(termsAgreement.isPrivacyTermsAgreed, forKey: "isPrivacyTermsAgreed")
        defaults.set(termsAgreement.isMarketingAgreed, forKey: "isMarketingAgreed")
    }
    
    func fetchTermsAgreement() -> TermsAgreement {
        let isServiceTermsAgreed = defaults.bool(forKey: "isServiceTermsAgreed")
        let isPrivacyTermsAgreed = defaults.bool(forKey: "isPrivacyTermsAgreed")
        let isMarketingAgreed = defaults.bool(forKey: "isMarketingAgreed")
        
        return TermsAgreement(isServiceTermsAgreed: isServiceTermsAgreed, isPrivacyTermsAgreed: isPrivacyTermsAgreed, isMarketingAgreed: isMarketingAgreed)
    }
}
