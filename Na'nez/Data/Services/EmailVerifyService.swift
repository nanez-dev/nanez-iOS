//
//  EmailVerifyService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/29/23.
//

import Foundation
import Alamofire
import RxSwift

class EmailVerifyService {
    
    func postEmailVerify(withCode code: Int, email: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/email-verify"
            let parameters: Parameters = [
                "code": code,
                "email": email
            ]
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]

            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        if let success = value as? Bool, success {
                            observer.onNext(true)
                        } else {
                            observer.onNext(false)
                        }
                    case .failure(let error):
                        print("Network error: \(error.localizedDescription)")
                        if let statusCode = response.response?.statusCode, statusCode == 404 {
                            observer.onNext(false)
                            print("Email not found")
                        } else {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                }
            return Disposables.create {}
        }
    }
}

