//
//  PerfumeDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
// 향수 정보 DTO
struct PerfumeDTO: Codable {
    let kor: String
    let is_single: Bool
    let image: String
    let web_image1: String
    let brand_id: Int
    let web_image2: String?
    let id: Int
    let capacity: Int
    let density_id: Int
    let price: Int
    let eng: String
    let title: String
    let subtitle: String
    let brand: BrandDTO
}
