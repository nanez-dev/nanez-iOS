//
//  SelectEmailViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import Foundation
import RxSwift

class SelectEmailViewModel {
    private let useCase: SelectEmailUseCase
    private let disposeBag = DisposeBag()
    private var countdownDisposable: Disposable?
    let countdownTimer = BehaviorSubject<String?>(value: nil)
    let countdownFinished = PublishSubject<Void>()
    let emailVerificationResult = PublishSubject<Bool>()
    
    let isAuthSent = PublishSubject<Bool>()
    
    init(useCase: SelectEmailUseCase) {
        self.useCase = useCase
    }
    
    func sendEmail(email: String) -> Observable<Bool> {
        return useCase.sendEmail(email: email)
            .do(onNext: { [weak self] success in
                self?.isAuthSent.onNext(success)
            })
    }
    
    func startCountdown(duration: Int) {
        countdownDisposable?.dispose()
        countdownDisposable = Observable<Int>.timer(.seconds(0), period: .seconds(1),scheduler: MainScheduler.instance)
            .take(duration + 1)
            .map { duration - $0 }
            .map { remainingSeconds in
                let minutes = remainingSeconds / 60
                let seconds = remainingSeconds % 60
                return String(format: "%02d:%02d", minutes, seconds)
            }
            .subscribe(onNext: { [weak self] formattedTime in
                self?.countdownTimer.onNext(formattedTime)
                if formattedTime == "00:00" {
                    self?.countdownTimer.onNext(nil)
                    self?.countdownFinished.onNext(())
                }
            })
        countdownDisposable?.disposed(by: disposeBag)
    }

    func verifyEmailCode(email: String, code: Int) {
        useCase.verifyEmailCode(email: email, code: code)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isMatched in
                if isMatched {
                    print("인증코드가 일치합니다")
                    self?.countdownDisposable?.dispose()
                    self?.emailVerificationResult.onNext(isMatched)
                } else {
                    print("인증코드가 불일치합니다")
                    self?.emailVerificationResult.onNext(isMatched)
                }
            }, onError: { [weak self] error in
                print("Error werifying email code: \(error)")
                self?.emailVerificationResult.onNext(false)
            }).disposed(by: disposeBag)
    }
}
