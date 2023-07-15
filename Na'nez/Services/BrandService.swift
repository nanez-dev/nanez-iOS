//
//  BrandService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire

struct Brand: Codable {
    let id: Int
    let eng: String
    let kor: String
    let image: String
}
struct BrandList: Codable {
    let brands: [Brand]
}

class BrandService{
    func getPoularBrands(completion: @escaping (Result<BrandList, Error>) -> Void) {
        let url = APIConstants.baseURL + "/brand/popular"
        AF.request(url).responseDecodable(of: BrandList.self) { response in
            switch response.result {
            case .success(let brandList):
                completion(.success(brandList))
            case .failure(let error):
                print("/brand/popular 오류:",error)
            }
        }
    }
    
}
