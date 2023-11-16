//
//  HomeService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import Alamofire
import RxSwift

class HomeService {
    func getHomeInfo() -> Single<PerfumeDataDTO> {
        let url = APIConstants.baseURL + "/perfume/main"
        
        return Single<PerfumeDataDTO>.create { observer in
            AF.request(url)
                .responseDecodable(of: PerfumeDataDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("홈화면 API 에러:\(error)")
                    }
                }
            return Disposables.create()
            
        }
    }
}
