//
//  MyInfoRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/26/24.
//

import Foundation
import RxSwift

protocol MyInfoRepositoryProtocol {
    func fetchMyInfo() -> Observable<MyInfoDTO>
}

final class MyInfoRepository: MyInfoRepositoryProtocol {
    private let myInfoService: MyInfoService
    
    init(myInfoService: MyInfoService) {
        self.myInfoService = myInfoService
    }
    
    func fetchMyInfo() -> Observable<MyInfoDTO> {
        return myInfoService.getMyInfo()
    }
}
