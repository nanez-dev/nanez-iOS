//
//  DetailBrandDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import Foundation

struct DetailBrandDTO: Codable {
    let id: Int
    let eng: String
    let kor: String
    let image: String
    let detail: DetailDTO?
    let relative_perfumes: [BrandPerfumeDTO?]
}

struct DetailDTO: Codable {
    let top_title: String
    let top_subtitle: String
    let bottom_title: String
    let bottom_subtitle: String
    let image1: String
    let image2: String
    let image3: String
    let image4: String
    let image5: String
    let id: Int
    let brand_id: Int
}

struct BrandPerfumeDTO: Codable {
    let id: Int
    let brand: BrandDTO
    let kor: String
    let eng: String
    let image: String?
    let capacity: Int
    let price: Int
}
