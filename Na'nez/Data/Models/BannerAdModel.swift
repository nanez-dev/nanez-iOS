//
//  BannerAdModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/14.
//

import Foundation
import UIKit

enum bannerImg: Int{
    case banner1 = 0
    case banner2 = 1
    case banner3 = 2
    case banner4 = 3
    case banner5 = 4
    
    var image: UIImage {
        switch self {
        case .banner1: return UIImage(named: "bannerAD1") ?? UIImage()
        case .banner2: return UIImage(named: "bannerAD2") ?? UIImage()
        case .banner3: return UIImage(named: "bannerAD3") ?? UIImage()
        case .banner4: return UIImage(named: "bannerAD4") ?? UIImage()
        case .banner5: return UIImage(named: "bannerAD5") ?? UIImage()
        }
    }
}
