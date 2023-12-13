//
//  DetailAccordDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import Foundation

struct DetailAccordDTO: Codable {
    let accord: AccordDTO
    let related_perfumes: [Relative_perfumes]
}

struct Relative_perfumes: Codable {
    let kor: String
    let is_single: Bool
    let image: String
    let web_image1: String
    let brand_id: Int
    let webImage2: String?
    let id: Int
    let capacity: Int
    let density_id: Int
    let price: Int
    let eng: String
    let title: String
    let subtitle: String
    let brand: BrandDTO
}
