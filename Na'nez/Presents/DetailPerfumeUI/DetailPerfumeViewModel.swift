//
//  DetailPerfumeViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

class DetailPerfumeViewModel:ViewModelType {

    var disposeBag = DisposeBag()
    let usecase: DetailPerfumeUseCaseProtocol
    let perfumeDetailInfo = PublishSubject<DetailPerfumeDTO>()
    let perfumeAccords = PublishSubject<[PerfumeAccordDTO]>()
    let perfumeNotes = PublishSubject<[PerfumeNoteDTO]>()

    struct Input{
        
    }
    
    struct Output{
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    init(usecase: DetailPerfumeUseCaseProtocol,id : Int) {
        self.usecase = usecase
        self.updateDetailInfo(id: id)
    }
    
    func updateDetailInfo(id: Int){
        self.usecase.getPerfumeInfo(with: id)
            .subscribe(onSuccess: { [weak self] info in
                self?.perfumeDetailInfo.onNext(info.perfume)
                self?.perfumeAccords.onNext(info.perfume.perfume_accords)
                self?.perfumeNotes.onNext(info.perfume.perfume_notes)
            }, onFailure: { error in
                print("DetailPerfumeVM 에러 발생: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
