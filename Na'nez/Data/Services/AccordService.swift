//
//  AccordService.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/15.
//

import Foundation
import Alamofire

class AccordService{
    func getAccord(completion: @escaping (Result<AccordList, Error>) -> Void) {
        let url = APIConstants.baseURL + "/accord"
        AF.request(url).responseDecodable(of: AccordList.self) { response in
            switch response.result {
            case .success(let accordList):
                completion(.success(accordList))
            case .failure(let error):
                print("/accord 오류:",error)
            }
        }
    }

}
