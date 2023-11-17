//
//  HomeUseCase.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

protocol HomeUseCaseProtocol {
    func getHomeInfo() -> Single<PerfumeDataDTO>
}

final class HomeUseCase:HomeUseCaseProtocol {

    private let repository: HomeRepositoryInterface

    init(repository: HomeRepositoryInterface) {
        self.repository = repository
    }
    
    func getHomeInfo() -> Single<PerfumeDataDTO> {
        return self.repository.getHomeInfo()
    }
}
