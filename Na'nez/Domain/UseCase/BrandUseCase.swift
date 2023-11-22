//
//  BrandUseCase.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/22.
//

import Foundation
import RxSwift

protocol BrandUseCaseProtocol {
    func getAllBrand() -> Single<AllBrandDTO>
    func getPopularBrand() -> Single<PopularBrandDTO>
}

final class BrandUseCase:BrandUseCaseProtocol {
    
    let repository: BrandRepository
    
    func getAllBrand() -> RxSwift.Single<AllBrandDTO> {
        return repository.getAllBrand()
    }
    
    func getPopularBrand() -> RxSwift.Single<PopularBrandDTO> {
        return repository.getPopularBrand()
    }
    
    init(_ repository: BrandRepository) {
        self.repository = repository
    }
}
