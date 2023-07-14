//
//  Colors.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
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
        
        // let's suppose alpha is the first component (ARGB)
        convenience init(argb: Int) {
            self.init(
                red: (argb >> 16) & 0xFF,
                green: (argb >> 8) & 0xFF,
                blue: argb & 0xFF,
                a: (argb >> 24) & 0xFF
            )
        }
}

