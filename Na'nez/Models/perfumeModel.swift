//
//  perfumeModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/04.
//

import Foundation

struct PerfumeResponse: Codable {
    let perfumes: [Perfume]
}
struct DetailPerfumeResponse: Codable {
    let perfume: Perfume
}
struct Perfume: Codable {
    let id: Int?
    let brand: Brands?
    let density: Density
    let kor: String
    let eng: String
    let image: String?
    let capacity: Int
    let price: Int
    let title: String
    let subtitle: String
    let is_single: Bool?
    let perfume_accords: [PerfumeAccord]
    let perfume_notes: [PerfumeNote]
    let perfume_tags: [PerfumeTag]
    let web_image1: String?
    let web_image2: String?
    let is_having: Bool?
    let is_wish: Bool?
}

struct Brands: Codable {
    let id: Int?
    let eng: String
    let kor: String
    let image: String
}

struct Density: Codable {
    let id: Int?
    let name: String
}

struct PerfumeAccord: Codable {
    let id: Int?
    let accord_id: Int
    let perfume_id: Int
    let accord: Accords
}

struct Accords: Codable {
    let eng: String
    let kor: String
    let image: String
    let code: Int
    let id: Int?
}

struct PerfumeNote: Codable {
    let id: Int?
    let perfume_id: Int
    let note_id: Int
    let type: String
    let note: Note
}

struct Note: Codable {
    let note_category_id: Int
    let code: Int
    let eng: String
    let kor: String
    let image: String?
    let illustration: String?
    let id: Int?
}

struct PerfumeTag: Codable {
    let id: Int?
    let tag_id: Int
    let perfume_id: Int
    let tag: Tag
}

struct Tag: Codable {
    let tag_category_id: Int
    let code: Int
    let name: String
    let id: Int?
}
