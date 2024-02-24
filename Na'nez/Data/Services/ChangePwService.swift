//
//  ChangePwService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/21/24.
//

import Foundation
import Alamofire
import RxSwift

class ChangePwService {
    
    func patchChangePw(currentPassword: String, newPassword: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/password"
            let parameters: [String: Any] = [
                "current_password": currentPassword,
                "new_password": newPassword
            ]
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        observer.onNext(true)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    
                    }
                }
            
            return Disposables.create()
        }
    }
}
