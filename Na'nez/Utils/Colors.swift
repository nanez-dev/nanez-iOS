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
  
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
  
}

