//
//  BrandDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

struct BrandDTO: Codable {
    let id: Int
    let image: String
    let eng: String
    let kor: String
}
// 인기 브랜드 목록 DTO

struct PopularBrandsDTO: Codable {
    let title: String
    let list: [BrandDTO]
}
