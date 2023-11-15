//
//  UserInfo.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/18.
//

import Foundation
struct UserInfo {
    static let shares = UserInfo()
    var access_token : String?
    var refresh_token: String?
    init(){}
}
