//
//  DetailPerfumeUseCase.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

protocol DetailPerfumeUseCaseProtocol {
    func getPerfumeInfo(with id: Int) -> Single<DetailPerfumeDTO>
}

class DetailPerfumeUseCase: DetailPerfumeUseCaseProtocol {
    
    private let repository: DetailPerfumeRepositoryInterface

    init(repository: DetailPerfumeRepositoryInterface) {
        self.repository = repository
    }
    
    func getPerfumeInfo(with id: Int) -> RxSwift.Single<DetailPerfumeDTO> {
        return repository.getPerfumeInfo(with: id)
    }
}
