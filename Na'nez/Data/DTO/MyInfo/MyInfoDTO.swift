//
//  MyInfoDTO.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/26/24.
//

import Foundation

struct MyInfoDTO: Codable {
    var id: Int
    var nickname: String
    var email: String
    var gender: String?
    var ageGroup: Int?
    var profileImage: String?
    var isAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case email
        case gender
        case ageGroup = "age_group"
        case profileImage = "profile_image"
        case isAdmin = "is_admin"
    }
}
