//
//  String+.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/17.
//

import Foundation
import UIKit

extension String{
    func formatPriceWithWon() -> String {
        guard let number = Double(self) else {
            return self
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        
        var formattedPrice = numberFormatter.string(from: NSNumber(value: number)) ?? self
        formattedPrice += "원"
        
        return formattedPrice
    }
    
    func fromNoteString(_ string: String) -> String {
        switch string {
        case "T":
            return "TopNote"
        case "M":
            return "MiddleNote"
        case "B":
            return "BottomNote"
        default:
            return "TopNote"
        }
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
