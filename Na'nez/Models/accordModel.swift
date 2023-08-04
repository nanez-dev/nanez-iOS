//
//  accordModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/08/04.
//

import Foundation
struct Accord: Codable {
    let id: Int
    let code: Int
    let eng: String
    let kor: String
    let image: String
}
struct AccordList: Codable {
    let accords: [Accord]
}
