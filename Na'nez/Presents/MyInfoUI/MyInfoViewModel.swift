//
//  MyInfoViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/07.
//

import Foundation
import RxSwift
import RxCocoa

class MyInfoViewModel: ViewModelType {
    private let myInfoUseCase: MyInfoUseCase
    var disposeBag = DisposeBag()
    
    struct Input {
        let isLoggedIn: Observable<Bool>
    }
    
    struct Output {
        let tableData: Driver<[String]>
        let userInfo: Driver<MyInfoDTO?>
    }
    
    init(myInfoUseCase: MyInfoUseCase) {
        self.myInfoUseCase = myInfoUseCase
    }
    
    func transform(input: Input) -> Output {
        let userInfo = input.isLoggedIn
            .flatMapLatest { [weak self] isLoggedIn -> Observable<MyInfoDTO?> in
                guard let self = self else { return Observable.just(nil) }
                if isLoggedIn {
                    return self.myInfoUseCase.execute()
                        .map { Optional($0) }
                        .catchError { error in
                            print("An error occurred: \(error)")
                            return Observable.just(nil)
                        }
                } else {
                    return Observable.just(nil)
                }
            }
            .asDriver(onErrorJustReturn: nil)

        let tableData = input.isLoggedIn
            .flatMapLatest { isLoggedIn -> Observable<[String]> in
                if isLoggedIn {
                    return Observable.just(AfterCustomerTable.allTexts)
                } else {
                    return Observable.just(BeforeCustomerTable.allTexts)
                }
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(tableData: tableData, userInfo: userInfo)
    }
}
