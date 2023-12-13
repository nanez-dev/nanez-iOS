//
//  PerfumeService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire
import RxSwift

class PerfumeService {
    func getPerfumeDetailInfo(id:Int) -> Single<DetailPerfumeResponse> {
        let url = APIConstants.baseURL + "/perfume/\(id)"
        
        return Single<DetailPerfumeResponse>.create { observer in
            AF.request(url)
                .responseDecodable(of: DetailPerfumeResponse.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("상세향수 API 에러:\(error)")
                        if let decodingError = error.underlyingError as? DecodingError {
                            print("디코딩 에러 디버그 설명:", decodingError.localizedDescription)
                        }
                    }
                }
            return Disposables.create()
            
        }
    }
    
    func fetchSearchPerfume(name: String?, offset: Int, limit: Int) -> Single<SearchDTO> {
        let url = APIConstants.baseURL + "/perfume"
        var parameters: [String: Any] = [:]

        // Add parameters to the dictionary if they are not nil
        if let name = name {
            parameters["name"] = name
        }


            parameters["offset"] = offset



            parameters["limit"] = limit
        
        return Single<SearchDTO>.create { observer in
            AF.request(url,parameters: parameters)
                .responseDecodable(of: SearchDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("검색 API 에러:\(error)")
                        if let decodingError = error.underlyingError as? DecodingError {
                            print("디코딩 에러 디버그 설명:", decodingError.localizedDescription)
                        }
                    }
                }
            return Disposables.create()
            
        }
    }
}
