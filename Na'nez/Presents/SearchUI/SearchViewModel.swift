//
//  SearchViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/13.
//

import Foundation
import RxSwift

import RxCocoa

class SearchViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    private let usecase: SearchUseCaseProtocol
    
    let searchText = BehaviorRelay<String>(value: "")
    
    let searchResult = PublishSubject<[SearchPerfumeDTO]>()
    
    struct Input {
        let searchText: Observable<String>
        let updateSearchList: (String) -> Void
    }
    
    struct Output {
        let searchResult: Observable<[SearchPerfumeDTO]>
    }
    
    func transform(input: Input) -> Output {
        input.searchText
            .bind(to: searchText)
            .disposed(by: disposeBag)
        
        input.searchText
            .debounce(.milliseconds(0), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                self?.updateSearchList(name: query, offset: 0, limit: 1)
            })
            .disposed(by: disposeBag)
        
        return Output(searchResult: searchResult.asObservable())
    }
    
    init(usecase: SearchUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func updateSearchList(name: String?, offset: Int?, limit: Int?) {
        usecase.fetchSearchPerfume(name: name, offset: offset!, limit: limit!)
            .subscribe(onSuccess: { [weak self] info in
                self?.searchResult.onNext(info.perfumes)
            })
            .disposed(by: disposeBag)
    }
}

