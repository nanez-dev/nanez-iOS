//
//  MyInfoViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/07.
//

import Foundation
import RxSwift
import RxCocoa

class MyInfoViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let isLoggedIn: Observable<Bool>
    }
    
    struct Output {
        let tableData: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let tableData = input.isLoggedIn
            .flatMapLatest { isLoggedIn -> Observable<[String]> in
                if isLoggedIn {
                    return Observable.just(AfterCustomerTable.allTexts)
                } else {
                    return Observable.just(BeforeCustomerTable.allTexts)
                }
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(tableData: tableData)
    }
}

