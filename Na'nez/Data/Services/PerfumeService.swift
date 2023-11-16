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
    func getPerfumeDetailInfo(id:Int) -> Single<DetailPerfumeDTO> {
        let url = APIConstants.baseURL + "/perfume/\(id)"
        
        return Single<DetailPerfumeDTO>.create { observer in
            AF.request(url)
                .responseDecodable(of: DetailPerfumeDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("상세향수 API 에러:\(error)")
                    }
                }
            return Disposables.create()
            
        }
    }
}
