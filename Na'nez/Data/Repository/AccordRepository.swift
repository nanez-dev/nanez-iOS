//
//  AccordRepository.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/23.
//

import Foundation
import RxSwift

protocol AccordRepositoryProtocol {
    func getAllAccord() -> Single<AllAccordDTO>
    func getDetailAccordInfo(with id:Int) -> Single<DetailAccordDTO>
}
final class AccordRepository: AccordRepositoryProtocol {
    
    let service:AccordService
    
    init(_ service:AccordService) {
        self.service = service
    }
    
    func getAllAccord() -> RxSwift.Single<AllAccordDTO> {
        return service.getAllAccord()
    }
    
    func getDetailAccordInfo(with id: Int) -> RxSwift.Single<DetailAccordDTO> {
        return service.getDetailAccordInfo(id: id)
    }
}

