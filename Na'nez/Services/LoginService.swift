//
//  LoginService.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/19.
//

import Foundation
import Alamofire

class LoginService {
    func postLogin(email:String, Pw:String, comletion: @escaping(Result<LoginResponse,Error>) -> Void) {
        let url = APIConstants.baseURL + "/users/signin"
        let parameter: Parameters = [
            "email" : email,
            "password" : Pw,
        ]
        
        
        //AlamoFire API
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case.success(let response) :
                comletion(.success(response))
                print(response)
            case.failure(let error) :
                comletion(.failure(error))
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            }
            
        }
    }
    
}
