//
//  HomeDTO.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation

// 전체 홈화면용 데이터 DTO
struct PerfumeDataDTO: Codable {
    let top_rolling_banner: TopRollingBannerDTO
    let special_perfumes: RecommendPerfumesDTO
    let recommend_perfumes: RecommendPerfumesDTO
    let popular_brands: PopularBrandsDTO
    let recommend_accords: RecommendAccordsDTO
}

//인기 브랜드 DTO
struct PopularBrandsDTO: Codable {
    let title: String
    let list: [BrandDTO]
}

// 추천 향수 목록 DTO
struct RecommendPerfumesDTO: Codable {
    let title: String
    let list: [PerfumeDTO]
}

// 추천 어코드 목록 DTO
struct RecommendAccordsDTO: Codable {
    let title: String
    let list: [AccordDTO]
}
