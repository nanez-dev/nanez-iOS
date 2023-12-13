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
        
    }
    
    struct Output {
        let tableData: Driver<[String]>

    }
    
    func transform(input: Input) -> Output {
        let tableData = Observable.just(CustomerTable.allTexts)
            .asDriver(onErrorJustReturn: [])

        return Output(tableData: tableData)
    }
}
