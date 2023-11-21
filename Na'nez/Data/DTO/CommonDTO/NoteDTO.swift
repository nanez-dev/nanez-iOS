//
//  NoteDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

//노트 정보
struct NoteDTO: Codable {
    let note_category_id: Int
    let code: Int
    let eng: String
    let kor: String
    let image: String?
    let illustration: String?
    let id: Int?
}
