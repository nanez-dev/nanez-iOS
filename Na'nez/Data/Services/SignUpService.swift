//
//  SignUpService.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/16/23.
//

import Foundation
import Alamofire
import RxSwift

class SignUpService {
    func postSignUp(signUpDTO: SignUpDTO) -> Single<UserInfo> {
        let url = APIConstants.baseURL + "/users/signup"
        let parameters: Parameters = [
            "nickname": signUpDTO.nickname,
            "email": signUpDTO.email,
            "password": signUpDTO.password,
            "gender": signUpDTO.gender,
            "age_group": signUpDTO.ageGroup,
            "refer_code": signUpDTO.referCode,
            "accord_id": signUpDTO.accordId,
            "is_accepted": signUpDTO.isAccepted,
            "profile_image": signUpDTO.profileImage
        ]
        
        return Single<UserInfo>.create { single in
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable { (response: DataResponse<UserInfo, AFError>) in
                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
