//
//  LoginModel.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/18.
//

import Foundation

struct LoginResponse: Codable {
    let access_token: String
    let refresh_token: String
    
    enum CodingKeys: String, CodingKey {
        case access_token = "access_token"
        case refresh_token = "refresh_token"
    }
}
