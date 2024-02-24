//
//  ResignUserService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/21/24.
//

import Foundation
import Alamofire
import RxSwift

class ResignUserService {
    
    func deleteResignUser() -> Observable<Void> {
        return Observable.create { observer in
            let url = APIConstants.baseURL + "/users/withdrawal"
            
            if let accessToken = TokenManager.shared.getAccessToken() {
                let headers: HTTPHeaders = [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(accessToken)"
                ]
                
                AF.request(url, method: .delete, headers: headers).response { response in
                    switch response.result {
                    case .success:
                        observer.onCompleted()
                        print("회원탈퇴 성공")
                    case .failure(let error):
                        observer.onError(error)
                        print("회원탈퇴 실패")
                    }
                }
                
                return Disposables.create()
            }
            else {
                observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "인증 토큰이 존재하지 않습니다."]))
                print("인증 토큰이 존재하지 않습니다.")
            }
            
            return Disposables.create()
        }
    }
}
