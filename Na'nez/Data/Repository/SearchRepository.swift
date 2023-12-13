//
//  SearchRepository.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/13.
//

import Foundation

import RxSwift

protocol SearchRepositoryInterface {
    func fetchSearchPerfume(name: String?, offset: Int, limit: Int) -> Single<SearchDTO>
}
final class SearchRepository: SearchRepositoryInterface {
    
    private let service: PerfumeService
    
    init(service: PerfumeService) {
        self.service = service
    }
    
    func fetchSearchPerfume(name: String?, offset: Int, limit: Int) -> RxSwift.Single<SearchDTO> {
        return service.fetchSearchPerfume(name: name, offset: offset, limit: limit)
    }
}
