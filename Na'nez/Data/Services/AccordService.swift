//
//  AccordService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire
import RxSwift

class AccordService{
    
    func getEntireAccord() -> Single<EntireAccordDTO> {
        let url = APIConstants.baseURL + "/accord"
        
        return Single<EntireAccordDTO>.create { observer in
            let request = AF.request(url)
                .responseDecodable(of: EntireAccordDTO.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(value))
                    case .failure(let error):
                        observer(.failure(error))
                        print("전체 어코드 API 에러: \(error.localizedDescription)")
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func getAllAccord() -> Single<AllAccordDTO> {
        let url = APIConstants.baseURL + "/accord/exhibition"
        
        return Single<AllAccordDTO>.create { observer in
            AF.request(url)
                .responseDecodable(of: AllAccordDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("모든어코드 API 에러:\(error)")
                    }
                }
            return Disposables.create()
        }
    }
    
    func getDetailAccordInfo(id:Int) -> Single<DetailAccordDTO> {
        let url = APIConstants.baseURL + "/accord/\(id)/exhibition"
        
        return Single<DetailAccordDTO>.create {  observer in
            AF.request(url)
                .responseDecodable(of: DetailAccordDTO.self) { res in
                    switch res.result {
                    case .success(let response):
                        observer(.success(response))
                    case .failure(let error):
                        print("어코드디테일API에러:\(error)")
                    }
                }
            return Disposables.create()
        }
    }
}
