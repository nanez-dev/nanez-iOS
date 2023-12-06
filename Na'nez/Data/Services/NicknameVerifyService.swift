//
//  NicknameVerifyService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/6/23.
//

import Foundation
import Alamofire
import RxSwift

class NicknameVerifyService {
    
    func postNicknameVerify(nickname: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/nickname-verify?nickname=\(nickname)"
            let headers: HTTPHeaders = ["accept": "application/json"]
            
            AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).response { response in
                switch response.result {
                case .success(let data):
                    if let data = data, let isAvailable = try? JSONDecoder().decode(Bool.self, from: data) {
                        observer.onNext(isAvailable)
                        observer.onCompleted()
                    }
                    else {
                        observer.onError(response.error ?? NSError(domain: "", code: -1, userInfo: nil))
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                AF.cancelAllRequests()
            }
        }
    }
}
