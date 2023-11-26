//
//  TermsUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/24/23.
//

import Foundation
import RxSwift

protocol TermsRepositoryeProtocol {
    func saveTermsAgreement(_ termsAgreement: TermsAgreement)
    func fetchTermsAgreement() -> TermsAgreement
}

protocol TermsUseCaseProtocol {
    var termsAgreement: BehaviorSubject<TermsAgreement> { get }
    func toggleServiceTermsAgreement()
    func togglePrivacyTermsAgreement()
    func toggleMarketingAgreement()
    func setAllAgreements(to value: Bool)
}

class TermsUseCase: TermsUseCaseProtocol {
    private let repository: TermsRepositoryeProtocol
    var termsAgreement: BehaviorSubject<TermsAgreement>
    
    init(repository: TermsRepositoryeProtocol) {
        self.repository = repository
        
        let currentAgreement = repository.fetchTermsAgreement()
        termsAgreement = BehaviorSubject<TermsAgreement>(value: currentAgreement)
    }
    
    func toggleServiceTermsAgreement() {
        updateAgreement { agreement in
            agreement.isServiceTermsAgreed.toggle()
        }
    }
    
    func togglePrivacyTermsAgreement() {
        updateAgreement { agreement in
            agreement.isPrivacyTermsAgreed.toggle()
        }
    }
    
    func toggleMarketingAgreement() {
        updateAgreement { agreement in
            agreement.isMarketingAgreed.toggle()
        }
    }
    
    func setAllAgreements(to value: Bool) {
        updateAgreement { agreement in
            agreement.isServiceTermsAgreed = value
            agreement.isPrivacyTermsAgreed = value
            agreement.isMarketingAgreed = value
        }
    }
    
    private func updateAgreement(updateBlock: (inout TermsAgreement) -> Void) {
        var currentAgreement = try! termsAgreement.value()
        updateBlock(&currentAgreement)
        
        repository.saveTermsAgreement(currentAgreement)
        termsAgreement.onNext(currentAgreement)
    }
}
