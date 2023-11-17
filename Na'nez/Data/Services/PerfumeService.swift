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
}
