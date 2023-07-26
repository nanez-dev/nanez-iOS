//
//  BannerAdModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/14.
//

import Foundation
import UIKit

enum bannerImg: String{
    case banner1 = "광고명1"
    case banner2 = "광고명2"
    case banner3 = "광고명3"
    case banner4 = "광고명4"
    case banner5 = "광고명5"
    
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
