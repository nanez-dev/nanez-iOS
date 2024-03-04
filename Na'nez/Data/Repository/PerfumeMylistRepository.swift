//
//  PerfumeMylistRepository.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 3/4/24.
//

import Foundation
import RxSwift

protocol PerfumeMylistRepositoryProtocol {
    func fetchMyList(btn: String) -> Observable<[PerfumeDTO]>
}

class PerfumeMylistRepository: PerfumeMylistRepositoryProtocol {
    private let perfumeService: PerfumeService
    
    init(perfumeService: PerfumeService) {
        self.perfumeService = perfumeService
    }
    
    func fetchMyList(btn: String) -> Observable<[PerfumeDTO]> {
        return perfumeService.getPerfumeMylist(btn: btn)
    }
}
