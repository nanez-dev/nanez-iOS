//
//  PerfumeTagDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

struct PerfumeTagDTO: Codable {
    let id: Int?
    let tag_id: Int
    let perfume_id: Int
    let tag: TagDTO
}
