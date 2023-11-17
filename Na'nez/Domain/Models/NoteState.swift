//
//  NoteState.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/17.
//

import Foundation

enum NoteStateEnum {
    case Top
    case Middle
    case Bottom
    
    static func fromString(_ string: String) -> NoteStateEnum? {
        switch string {
        case "T":
            return ".Top"
        case "M":
            return .Middle
        case "B":
            return .Bottom
        default:
            return nil
        }
    }
}
