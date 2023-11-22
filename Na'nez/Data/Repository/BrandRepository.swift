//
//  BrandRepository.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/22.
//

import Foundation
import RxSwift

protocol BrandRepositoryProtocol {
    func getAllBrand() -> Single<AllBrandDTO>
    func getPopularBrand() -> Single<PopularBrandDTO>
}

class BrandRepository:BrandRepositoryProtocol {
    
    let service:BrandService
    
    func getAllBrand() -> RxSwift.Single<AllBrandDTO> {
        return service.getAllBrand()
    }
    
    func getPopularBrand() -> RxSwift.Single<PopularBrandDTO> {
        return service.getPopularBrand()
    }
    
    init(_ service:BrandService) {
        self.service = service
    }
}
