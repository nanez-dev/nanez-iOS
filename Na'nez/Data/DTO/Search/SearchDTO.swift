//
//  SearchDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/13.
//

import Foundation

struct SearchDTO: Decodable {
    let perfumes: [SearchPerfumeDTO]
}
struct SearchPerfumeDTO: Decodable {
    let kor: String
    let is_single: Bool
    let image: String?
    let web_image1: String?
    let web_image2: String?
    let id: Int
    let capacity: Int?
    let price: Int?
    let eng: String?
    let title: String?
    let subtitle: String?
    let brand: BrandDTO?
    let perfume_accords: [PerfumeAccordDTO?]
    let perfume_notes: [PerfumeNoteDTO?]
    let perfume_tags: [PerfumeTagDTO?]
    let is_having: Bool?
    let is_wish: Bool?
}
