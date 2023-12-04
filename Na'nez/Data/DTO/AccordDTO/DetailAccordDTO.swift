//
//  DetailAccordDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import Foundation

struct DetailAccordDTO: Codable {
    let accord: AccordDTO
    let relative_perfumes: [Relative_perfumes]
}

struct Relative_perfumes: Codable {
    let kor: String
    let isSingle: Bool
    let image: String
    let webImage1: String
    let brandId: Int
    let webImage2: String?
    let id: Int
    let capacity: Int
    let densityId: Int
    let price: Int
    let eng: String
    let title: String
    let subtitle: String
    let brand: BrandDTO
}
