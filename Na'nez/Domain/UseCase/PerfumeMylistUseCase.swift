//
//  PerfumeMylistUseCase.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 3/4/24.
//

import Foundation
import RxSwift

class PerfumeMylistUseCase {
    private let repository: PerfumeMylistRepositoryProtocol
    
    init(repository: PerfumeMylistRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(btn: String) -> Observable<[PerfumeDTO]> {
        return repository.fetchMyList(btn: btn)
    }
}
