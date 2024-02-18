//
//  TokenManager.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/30/24.
//

import KeychainSwift

class TokenManager {
    static let shared = TokenManager()
    let keychain = KeychainSwift()
    
    private init() {}
    
    func saveTokens(accessToken: String, refreshToken: String) {
        keychain.set(accessToken, forKey: "AccessToken")
        keychain.set(refreshToken, forKey: "RefreshToken")
    }
    
    func getAccessToken() -> String? {
        return keychain.get("AccessToken")
    }
    
    func getRefreshToken() -> String? {
        return keychain.get("RefreshToken")
    }
    
    func deleteTokens() {
        keychain.delete("AccessToken")
        keychain.delete("RefreshToken")
    }
    
    func logout() {
        deleteTokens()
    }
}
