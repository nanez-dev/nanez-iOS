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
    let perfumeMylistUseCase: PerfumeMylistUseCase
    private let myInfoUseCase: MyInfoUseCase
    var disposeBag = DisposeBag()
    
    struct Input {
        let isLoggedIn: Observable<Bool>
        let btnSelection: Observable<String>
    }
    
    struct Output {
        let tableData: Driver<[String]>
        let userInfo: Driver<MyInfoDTO?>
        let holdingListCount: Observable<Int>
        let wishListCount: Observable<Int>
    }
    
    init(perfumeMylistUseCase: PerfumeMylistUseCase, myInfoUseCase: MyInfoUseCase) {
        self.perfumeMylistUseCase = perfumeMylistUseCase
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
        
        let holdingListCount = input.isLoggedIn
            .filter { $0 }
            .flatMapLatest { [weak self] _ -> Observable<Int> in
                guard let self = self else { return Observable.just(0) }
                return self.perfumeMylistUseCase.execute(btn: "having")
                    .map { $0.count }
                    .catchAndReturn(0)
            }
        
        let wishListCount = input.isLoggedIn
            .filter { $0 }
            .flatMapLatest { [weak self] _ -> Observable<Int> in
                guard let self = self else { return Observable.just(0) }
                return self.perfumeMylistUseCase.execute(btn: "wish")
                    .map { $0.count }
                    .catchAndReturn(0)
            }
        
        return Output(
            tableData: tableData,
            userInfo: userInfo,
            holdingListCount: holdingListCount,
            wishListCount: wishListCount
        )
    }
}
