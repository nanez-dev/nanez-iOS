//
//  DetailPerfumeRepository.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

protocol DetailPerfumeRepositoryInterface {
    func getPerfumeInfo(with id: Int) -> Single<DetailPerfumeResponse>
}

class DetailPerfumeRepository: DetailPerfumeRepositoryInterface {
        
    private let detailPerfumeService: PerfumeService
    
    init(detailPerfumeService: PerfumeService) {
        self.detailPerfumeService = detailPerfumeService
    }
    
    func getPerfumeInfo(with id: Int) -> Single<DetailPerfumeResponse> {
        return detailPerfumeService.getPerfumeDetailInfo(id: id)
    }
}
