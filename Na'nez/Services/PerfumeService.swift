//
//  PerfumeService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire
struct PerfumeResponse: Codable {
    let perfumes: [Perfume]
}
struct DetailPerfumeResponse: Codable {
    let perfume: Perfume
}
struct Perfume: Codable {
    let id: Int?
    let brand: Brands?
    let density: Density
    let kor: String
    let eng: String
    let image: String?
    let capacity: Int
    let price: Int
    let title: String
    let subtitle: String
    let is_single: Bool?
    let perfume_accords: [PerfumeAccord]
    let perfume_notes: [PerfumeNote]
    let perfume_tags: [PerfumeTag]
    let web_image1: String?
    let web_image2: String?
    let is_having: Bool?
    let is_wish: Bool?
}

struct Brands: Codable {
    let id: Int?
    let eng: String
    let kor: String
    let image: String
}

struct Density: Codable {
    let id: Int?
    let name: String
}

struct PerfumeAccord: Codable {
    let id: Int?
    let accord_id: Int
    let perfume_id: Int
    let accord: Accords
}

struct Accords: Codable {
    let eng: String
    let kor: String
    let image: String
    let code: Int
    let id: Int?
}

struct PerfumeNote: Codable {
    let id: Int?
    let perfume_id: Int
    let note_id: Int
    let type: String
    let note: Note
}

struct Note: Codable {
    let note_category_id: Int
    let code: Int
    let eng: String
    let kor: String
    let image: String?
    let illustration: String?
    let id: Int?
}

struct PerfumeTag: Codable {
    let id: Int?
    let tag_id: Int
    let perfume_id: Int
    let tag: Tag
}

struct Tag: Codable {
    let tag_category_id: Int
    let code: Int
    let name: String
    let id: Int?
}

class PerfumeService
{
    func getAllPerfumes(offset: Int, limit: Int,completion: @escaping (Result<[Perfume], Error>) -> Void) {
        let url = APIConstants.baseURL + "/perfume"
        let parameters: Parameters = [
            "offset": offset,
            "limit": limit
        ]
        AF.request(url, parameters: parameters).responseDecodable(of: PerfumeResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      completion(.success(response.perfumes))
                  case .failure(let error):
                      completion(.failure(error))
                  }
        }
    }
    func getPerfumeDetailInfo(id: Int,completion: @escaping (Result<Perfume, Error>) -> Void) {

        let url = APIConstants.baseURL + "/perfume/\(id)"
        AF.request(url).responseDecodable(of: DetailPerfumeResponse.self) { response in
                  switch response.result {
                  case .success(let response):
                      completion(.success(response.perfume))
                  case .failure(let error):
                      completion(.failure(error))
                      print("세부향수불러오기 실패 \(error)")
                  }
        }
    }
}
