//
//  LoginService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/23/23.
//

import Foundation
import Alamofire
import RxSwift

class LoginService {
    
    func postLogin(email: String, Pw: String) -> Observable<LoginResponse> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/signin"
            let parameters: Parameters = [
                "email": email,
                "password": Pw,
            ]
            
            let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseDecodable(of: LoginResponse.self) { response in
                    switch response.result {
                    case .success(let loginResponse):
                        observer.onNext(loginResponse)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                        if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                            print("Response JSON: \(jsonString)")
                        }
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
