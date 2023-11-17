//
//  HomeRepository.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

protocol HomeRepositoryInterface {
    func getHomeInfo() -> Single<PerfumeDataDTO>
}

class HomeRepository: HomeRepositoryInterface {
    
    private let homeService: HomeService
    
    init(homeService: HomeService) {
        self.homeService = homeService
    }

    func getHomeInfo() -> Single<PerfumeDataDTO> {
        return homeService.getHomeInfo()
    }
}
