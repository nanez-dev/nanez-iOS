//
//  MyInfoService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/26/24.
//

import Foundation
import Alamofire
import RxSwift

enum MyServiceError: Error {
    case notAuthenticated
    case other(Error)
}

class MyInfoService {
    func getMyInfo() -> Observable<MyInfoDTO> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/me"
            guard let accessToken = TokenManager.shared.getAccessToken() else {
                observer.onError(MyServiceError.notAuthenticated)
                return Disposables.create()
            }
            
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request(url, method: .get, headers: headers).responseDecodable(of: MyInfoDTO.self) { response in
                switch response.result {
                case .success(let myInfoDTO):
                    observer.onNext(myInfoDTO)
                    observer.onCompleted()
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
