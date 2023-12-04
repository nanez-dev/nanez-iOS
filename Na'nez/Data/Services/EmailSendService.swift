//
//  EmailSendService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import Foundation
import Alamofire
import RxSwift

class EmailSendService {
    
    func postEmailSend(email: String) -> Observable<Bool> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/email-send"
            let parameters = ["email": email]
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        observer.onNext(true)
                        observer.onCompleted()
                    case .failure(let error):
                        print("Failure with error: \(error)")
                        if let data = response.data, let errorString = String(data: data, encoding: .utf8) {
                            print("Server response: \(errorString)")
                        }
                        observer.onNext(false) // 실패했을 때도 정보를 전달할 수 있도록 onNext를 호출합니다.
                        observer.onCompleted()
                    }
                }
            
            return Disposables.create()
        }
    }
}
