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
                    if let json = value as? [String: Any], json["detail"] as? String == "NOT_FOUND_USER" {
                        // 사용자를 찾을 수 없을 때 처리
                        print("API 실패: 사용자를 찾을 수 없음")
                        observer.onError(NSError(domain: "UserNotFoundError", code: 404, userInfo: nil))
                    } else {
                        // 성공 처리
                        print("API 성공")
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    print("API 실패: \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
