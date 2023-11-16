//
//  perfumeModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/04.
//

import Foundation

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
