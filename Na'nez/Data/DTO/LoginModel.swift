//
//  LoginModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
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
