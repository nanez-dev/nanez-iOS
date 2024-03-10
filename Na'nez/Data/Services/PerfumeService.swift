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
    
    func getPerfumeMylist(btn: String) -> Observable<[PerfumeDTO]> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/perfume/my-list"
            
            if let accessToken = TokenManager.shared.getAccessToken() {
                let parameters: [String: Any] = ["btn": btn]
                let headers: HTTPHeaders = [
                    "Accept": "application/json",
                    "Authorization": "Bearer \(accessToken)"
                ]
                
                AF.request(url, method: .get, parameters: parameters, headers: headers).responseData { response in
                    switch response.result {
                    case .success(let data):
                        print(String(data: data, encoding: .utf8) ?? "Invalid response data")
                        do {
                            let perfumes = try JSONDecoder().decode([PerfumeDTO].self, from: data)
                            observer.onNext(perfumes)
                        } catch {
                            print(error)
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            }
            else {
                observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "인증 토큰이 존재하지 않습니다."]))
                print("인증 토큰이 존재하지 않습니다.")
            }
            
            return Disposables.create()
        }
    }
}
