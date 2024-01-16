//
//  FindPwViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/13/23.
//

import Foundation
import RxSwift

class FindPwViewModel {
    private let useCase: FindPwUseCase
    private let disposeBag = DisposeBag()
    
    let postFindPwSuccess = PublishSubject<Bool>()
    
    init(useCase: FindPwUseCase) {
        self.useCase = useCase
    }
    
    func postFindPw(email: String) {
        useCase.execute(email: email)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] success in
                self?.postFindPwSuccess.onNext(success)
                print("비밀번호 찾기 성공")
            }, onError: { error in
                if let error = error as NSError?, error.domain == "UserNotFoundError" {
                    print("사용자를 찾을 수 없습니다.")
                    self.postFindPwSuccess.onNext(false)
                }
                else {
                    print("Error: \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
    }
}
