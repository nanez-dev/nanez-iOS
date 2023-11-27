//
//  TermsConditionViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/24/23.
//

import Foundation
import RxSwift
import RxCocoa

class TermsConditionViewModel {
    private let termsUseCase: TermsUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    let inputServiceAgreement = PublishSubject<Void>()
    let inputPrivacyAgreement = PublishSubject<Void>()
    let inputMarketingAgreement = PublishSubject<Void>()
    let inputAllAgreements = PublishSubject<Bool>()
    
    let termsAgreement: BehaviorSubject<TermsAgreement>
    
    init(termsUseCase: TermsUseCaseProtocol) {
        self.termsUseCase = termsUseCase
        self.termsAgreement = termsUseCase.termsAgreement
        
        inputServiceAgreement
            .subscribe(onNext: { [weak self] _ in
                self?.termsUseCase.toggleServiceTermsAgreement()
            }).disposed(by: disposeBag)

        inputPrivacyAgreement
            .subscribe(onNext: { [weak self] _ in
                self?.termsUseCase.togglePrivacyTermsAgreement()
            }).disposed(by: disposeBag)

        inputMarketingAgreement
            .subscribe(onNext: { [weak self] _ in
                self?.termsUseCase.toggleMarketingAgreement()
            }).disposed(by: disposeBag)

        inputAllAgreements
            .subscribe(onNext: { [weak self] value in
                self?.termsUseCase.setAllAgreements(to: value)
            }).disposed(by: disposeBag)
        
    }
    
    func agreementStatus() -> Observable<TermsAgreement> {
        return termsAgreement.asObservable()
    }
    
}
