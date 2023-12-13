//
//  SearchUseCase.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/13.
//

import Foundation

import RxSwift

protocol SearchUseCaseProtocol {
    func fetchSearchPerfume(name: String?, offset: Int, limit: Int) -> Single<SearchDTO>
}
final class SearchUseCase: SearchUseCaseProtocol {
    
    private let repository: SearchRepositoryInterface
    
    init(repository: SearchRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchSearchPerfume(name: String?, offset: Int, limit: Int) -> RxSwift.Single<SearchDTO> {
        return repository.fetchSearchPerfume(name: name, offset: offset, limit: limit)
    }
}
