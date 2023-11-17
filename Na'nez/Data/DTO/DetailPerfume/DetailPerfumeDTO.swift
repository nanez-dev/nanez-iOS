//
//  DetailPerfumeDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

struct DetailPerfumeDTO: Codable {
    let id: Int?
    let brand: BrandDTO
    let density: DensityDTO
    let kor: String
    let eng: String
    let image: String?
    let capacity: Int
    let price: Int
    let title: String
    let subtitle: String
    let is_single: Bool?
    let perfume_accords: [PerfumeAccordDTO]
    let perfume_notes: [PerfumeNoteDTO]
    let perfume_tags: [PerfumeTagDTO]
    let web_image1: String?
    let web_image2: String?
    let is_having: Bool?
    let is_wish: Bool?
}

struct DetailPerfumeResponse: Codable {
    let perfume: DetailPerfumeDTO
}
