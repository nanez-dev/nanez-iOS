//
//  TagDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

//Tag 정보
struct TagDTO: Codable {
    let tag_category_id: Int
    let code: Int
    let name: String
    let id: Int?
}
