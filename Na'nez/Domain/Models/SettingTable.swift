//
//  SettingTable.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/19/24.
//

import Foundation

enum SettingTable: String, CaseIterable {
    case table1
    case table2
    
    var text: String {
        switch self {
        case .table1: return "로그아웃"
        case .table2: return "회원탈퇴"
        }
    }
    
    static var allTexts: [String] {
        return [table1, table2].map { $0.text }
    }
}
