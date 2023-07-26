//
//  reportModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/25.
//

import Foundation

enum reportReson: Int {
    case reportReson1 = 0
    case reportReson2 = 1
    case reportReson3 = 2
    case reportReson4 = 3
    case reportReson5 = 4
    
    var reson: String {
        switch self {
        case .reportReson1: return "사유1"
        case .reportReson2: return "사유2"
        case .reportReson3: return "사유3"
        case .reportReson4: return "사유4"
        case .reportReson5: return "사유5"
        }
    }
}
