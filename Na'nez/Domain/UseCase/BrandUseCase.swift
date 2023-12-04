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
    func getDetailBrandInfo(with id: Int,with limit:Int) -> Single<DetailBrandDTO>
}

final class BrandUseCase:BrandUseCaseProtocol {

    let repository: BrandRepository
    
    func getAllBrand() -> RxSwift.Single<AllBrandDTO> {
        return repository.getAllBrand()
    }
    
    func getPopularBrand() -> RxSwift.Single<PopularBrandDTO> {
        return repository.getPopularBrand()
    }
    
    func getDetailBrandInfo(with id: Int, with limit: Int) -> RxSwift.Single<DetailBrandDTO> {
        return repository.getDetailBrandInfo(with: id, with: limit)
    }
    
    init(_ repository: BrandRepository) {
        self.repository = repository
    }
}
