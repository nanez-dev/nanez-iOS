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
    func getDetailBrandInfo(with id: Int,with limit:Int) -> Single<DetailBrandDTO>
}

final class BrandRepository:BrandRepositoryProtocol {
    
    let service:BrandService
    
    func getAllBrand() -> RxSwift.Single<AllBrandDTO> {
        return service.getAllBrand()
    }
    
    func getPopularBrand() -> RxSwift.Single<PopularBrandDTO> {
        return service.getPopularBrand()
    }
    
    func getDetailBrandInfo(with id: Int, with limit: Int) -> Single<DetailBrandDTO> {
        return service.getDetailBrandInfo(id: id, limit: limit)
    }
    
    init(_ service:BrandService) {
        self.service = service
    }
}
