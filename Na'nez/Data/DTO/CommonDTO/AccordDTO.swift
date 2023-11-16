//
//  AccordDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

// 어코드 정보 DTO
struct AccordDTO: Codable {
    let code: Int
    let kor: String
    let id: Int
    let eng: String
    let image: String
}

// 추천 어코드 목록 DTO
struct RecommendAccordsDTO: Codable {
    let title: String
    let list: [AccordDTO]
}
