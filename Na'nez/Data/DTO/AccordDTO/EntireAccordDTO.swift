//
//  EntireAccordDTO.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/14/23.
//

import Foundation

struct Accord: Codable {
    let id: Int
    let code: Int
    let eng: String
    let kor: String
    let image: String
}

struct EntireAccordDTO: Codable {
    let accords: [Accord]
}
