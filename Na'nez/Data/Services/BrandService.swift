//
//  BrandService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire
import RxSwift

class BrandService{
    func getAllBrand() -> Single<AllBrandDTO> {
        let url = APIConstants.baseURL + "/brand"
        
        return Single<AllBrandDTO>.create { observer in
            AF.request(url)
                .responseDecodable(of: AllBrandDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("모든브랜드 API 에러:\(error)")
                    }
                }
            return Disposables.create()
        }
    }
    
    func getPopularBrand() -> Single<PopularBrandDTO> {
        let url = APIConstants.baseURL + "/brand/popular"
        
        return Single<PopularBrandDTO>.create { observer in
            AF.request(url)
                .responseDecodable(of: PopularBrandDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("인기브랜드 API 에러:\(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
