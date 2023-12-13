//
//  CustomerTable.swift
//  Na'nez
//
//  Created by 최지철 on 2023/12/07.
//

import Foundation

enum CustomerTable: String{
    case table1
    case table2
    case table3
    case table4
    case table5
    
    var text: String {
        switch self {
        case .table1: return "공지사항"
        case .table2: return "제품등록요청"
        case .table3: return "신고하기"
        case .table4: return "서비스이용약관"
        case .table5: return "개인정보처리방침"
        }
    }
    
    static var allTexts: [String] {
        return [table1, table2, table3, table4, table5].map { $0.text }
    }
}
