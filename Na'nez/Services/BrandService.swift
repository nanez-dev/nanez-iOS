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
struct DetailBrandInfo: Codable {
    let id: Int
    let eng: String
    let kor: String
    let image: String
    let detail: Detail?
    let relativePerfumes: [RelativePerfume]

    enum CodingKeys: String, CodingKey {
        case id, eng, kor, image, detail
        case relativePerfumes = "relative_perfumes"
    }
}
struct Detail: Codable {
    let topTitle: String?
    let topSubtitle: String?
    let bottomTitle: String?
    let bottomSubtitle: String?
    let image1: String?
    let image2: String?
    let image3: String?
    let image4: String?
    let image5: String?
    let id: Int?
    let brandId: Int?

    enum CodingKeys: String, CodingKey {
        case topTitle = "top_title"
        case topSubtitle = "top_subtitle"
        case bottomTitle = "bottom_title"
        case bottomSubtitle = "bottom_subtitle"
        case image1, image2, image3, image4, image5, id
        case brandId = "brand_id"
    }
}
struct RelativePerfume: Codable {
    let id: Int
    let brand: Brand
    let kor: String
    let eng: String
    let image: String?
    let capacity: Int
    let price: Int
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
}
