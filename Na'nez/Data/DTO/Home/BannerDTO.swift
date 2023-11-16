//
//  BannerDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

// 롤링 배너 DTO

struct RollingBannerItemDTO: Codable {
    let id: Int
    let image: String
    let link: String?
}

struct TopRollingBannerDTO: Codable {
    let title: String
    let subtitle: String
    let list: [RollingBannerItemDTO]
}
