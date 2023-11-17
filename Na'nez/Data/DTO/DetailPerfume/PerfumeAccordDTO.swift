//
//  PerfumeAccordDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

struct PerfumeAccordDTO: Codable {
    let id: Int?
    let accord_id: Int
    let perfume_id: Int
    let accord: AccordDTO
}

