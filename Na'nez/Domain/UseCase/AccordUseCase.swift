//
//  AccordUseCase.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/24.
//

import Foundation
import RxSwift

protocol AccordUseCaseProtocol{
    func getAllAccord() -> Single<AllAccordDTO>
    func getDetailAccordInfo(with id:Int) -> Single<DetailAccordDTO>
}
final class AccordUseCase:AccordUseCaseProtocol {
    
    let repository: AccordRepository
    
    init(_ repository: AccordRepository) {
        self.repository = repository
    }
    
    func getAllAccord() -> RxSwift.Single<AllAccordDTO> {
        return repository.getAllAccord()
    }
    
    func getDetailAccordInfo(with id: Int) -> RxSwift.Single<DetailAccordDTO> {
        return repository.getDetailAccordInfo(with: id)
    }
}
