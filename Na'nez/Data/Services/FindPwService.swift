//
//  FindPwService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 1/10/24.
//

import Foundation
import Alamofire
import RxSwift

class FindPwService {
    
    func postFindPw(email: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/reset-random-password"
            let parameters = ["email": email]
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], let result = json["result"] as? Bool {
                        print("APi 성공")
                        observer.onNext(result)
                        observer.onCompleted()
                    } else {
                        print("APi 실패")
                        observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
