//
//  MyInfoUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/26/24.
//

import Foundation
import RxSwift

final class MyInfoUseCase {
    private let repository: MyInfoRepository
    
    init(repository: MyInfoRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<MyInfoDTO> {
        return repository.fetchMyInfo()
    }
}
