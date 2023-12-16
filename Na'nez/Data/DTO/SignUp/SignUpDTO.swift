//
//  SignUpDTO.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/16/23.
//

import Foundation

struct SignUpDTO: Codable {
    let nickname: String
    let email: String
    let password: String
    let gender: String
    let ageGroup: Int
    let referCode: String
    let accordId: Int
    let isAccepted: Bool
    let profileImage: String
}
