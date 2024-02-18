//
//  AfterCustomerTable.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/9/24.
//

import Foundation

enum AfterCustomerTable: String{
    case table1
    case table2
    case table3
    case table4
    case table5
    case table6
    case table7
    
    var text: String {
        switch self {
        case .table1: return "공지사항"
        case .table2: return "제품등록요청"
        case .table3: return "신고하기"
        case .table4: return "비밀번호 변경"
        case .table5: return "서비스이용약관"
        case .table6: return "개인정보처리방침"
        case .table7: return "로그아웃"
        }
    }
    
    static var allTexts: [String] {
        return [table1, table2 ,table3, table4, table5, table6, table7].map { $0.text }
    }
}
