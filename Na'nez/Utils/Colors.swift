//
//  Colors.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
    class var mainGray: UIColor { UIColor(named: "mainGray") ?? UIColor() } //주로 버튼에쓰이는 그레이
    class var mainturquoise: UIColor { UIColor(named: "mainturquoise") ?? UIColor() } // 버튼에 주로쓰이는 청록 
    class var gragray: UIColor { UIColor(named: "gragray") ?? UIColor() } // 그라데이션그레이
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: CGFloat(a) / 255.0
            )
        }
        convenience init(rgb: Int) {
               self.init(
                   red: (rgb >> 16) & 0xFF,
                   green: (rgb >> 8) & 0xFF,
                   blue: rgb & 0xFF
               )
           }
        
}

