//
//  PerfumeService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire


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
