//
//  CouponViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/8/23.
//

import Foundation
import RxSwift
import RxCocoa

class CouponViewModel {
    private let signUpUseCase: SignUpUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: SignUpUseCase) {
        self.signUpUseCase = useCase
    }
    
    func signUp(dto: SignUpDTO) {
        signUpUseCase.execute(signUpDTO: dto)
            .subscribe(
                onSuccess: { userInfo in
                    print("회원가입에 성공하였습니다.")
//                    self?.showSameAlert()
                },
                onFailure: { error in
                    print("회원가입에 실패하였습니다: \(error.localizedDescription)")
                }
            ).disposed(by: disposeBag)
    }
    
//    private func showSameAlert() {
//        let alertView = CustomAlertView()
//        alertView.configure(message: "축하합니다! 회원가입에 성공하셨습니다!", actionButtonTitle: "확인")
//        alertView.onActionButotnTapped = {
//            alertView.dismiss()
//            self?.showEmailLoginView()
//        }
//        alertView.show(on: self.view)
//    }
//    
//    private func showEmailLoginView() {
//        let emailLoginVC = EmailLoginViewController()
//        self.pushViewController(emailLoginVC, animated: true)
//    }
}
