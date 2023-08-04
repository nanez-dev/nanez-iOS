//
//  BrandService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire


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
    func getBrandDetail(brand_id:Int,limit:Int,completion: @escaping(Result<DetailBrandInfo,Error>)-> Void){
        let url = APIConstants.baseURL + "/brand/\(brand_id)"
        let parameters: Parameters = [
             "limit": limit,
         ]
        AF.request(url, parameters: parameters).responseDecodable(of: DetailBrandInfo.self) { response in
            switch response.result {
            case .success(let detailBrand):
                completion(.success(detailBrand))
            case .failure(let error):
                print("/brand/Detail 오류:", error)
            }
        }
    }
    func getAllBrand(completion: @escaping (Result<BrandList, Error>) -> Void) {
        let url = APIConstants.baseURL + "/brand"
        AF.request(url).responseDecodable(of: BrandList.self) { response in
            switch response.result {
            case .success(let brandList):
                completion(.success(brandList))
            case .failure(let error):
                print("/brand(모든) 오류:",error)
            }
        }
    }
}
