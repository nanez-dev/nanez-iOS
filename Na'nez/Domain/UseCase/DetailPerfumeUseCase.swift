//
//  DetailPerfumeUseCase.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

protocol DetailPerfumeUseCaseProtocol {
    func getPerfumeInfo(with id: Int) -> Single<DetailPerfumeResponse>
}

class DetailPerfumeUseCase: DetailPerfumeUseCaseProtocol {
    
    private let repository: DetailPerfumeRepositoryInterface

    init(repository: DetailPerfumeRepositoryInterface) {
        self.repository = repository
    }
    
    func getPerfumeInfo(with id: Int) -> RxSwift.Single<DetailPerfumeResponse> {
        return repository.getPerfumeInfo(with: id)
    }
}
