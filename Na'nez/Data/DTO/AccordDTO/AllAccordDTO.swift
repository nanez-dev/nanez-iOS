//
//  AllAccordDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import Foundation

struct PopularAccord: Codable {
    let id: Int
    let code: Int
    let eng: String
    let kor: String
    let image: String
    let desc: String
}

struct AllAccordDTO:Codable {
    let popular_accords: [PopularAccord]
    let accords: [AccordDTO]
}
