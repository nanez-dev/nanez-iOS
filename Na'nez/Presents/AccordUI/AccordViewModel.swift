//
//  AccordViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import Foundation
import RxSwift

class AccordViewModel:ViewModelType {
    
    var disposeBag = DisposeBag()
    let usecase: AccordUseCaseProtocol
    let accords = PublishSubject<[AccordDTO]>()
    let popular = PublishSubject<[PopularAccord]>()
    let detail = PublishSubject<DetailAccordDTO>()

    struct Input{
        
    }
    
    struct Output{
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    init(usecase: AccordUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func updateAllAccord() {
        usecase.getAllAccord()
            .subscribe(
                onSuccess: { [weak self] list in
                    self?.accords.onNext(list.accords)
                    self?.popular.onNext(list.popular_accords)
            },
                onFailure: { error in
                    print("AccordVM에러:\(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func upadateAccordDetail(id: Int) {
        usecase.getDetailAccordInfo(with: id)
            .subscribe(
                onSuccess: { [weak self] info in
                    self?.detail.onNext(info)
            },
                onFailure: { error in
                    print("AccordVM에러:\(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}
