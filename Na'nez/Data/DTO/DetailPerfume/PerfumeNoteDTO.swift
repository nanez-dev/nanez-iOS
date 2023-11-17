//
//  PerfumeNoteDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

struct PerfumeNoteDTO: Codable {
    let id: Int?
    let perfume_id: Int
    let note_id: Int
    let type: String
    let note: NoteDTO
}
