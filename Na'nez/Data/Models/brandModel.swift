//
//  brandModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/04.
//

import Foundation

struct Brand: Codable {
    let id: Int
    let eng: String
    let kor: String
    let image: String?
}
struct BrandList: Codable {
    let brands: [Brand]
}
struct DetailBrandInfo: Codable {
    let id: Int
    let eng: String
    let kor: String
    let image: String?
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
