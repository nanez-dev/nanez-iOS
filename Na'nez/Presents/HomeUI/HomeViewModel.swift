//
//  HomeViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

class HomeViewModel: ViewModelType {
    
    let homeInfo = PublishSubject<PerfumeDataDTO>()
    let bannerInfo = PublishSubject<[RollingBannerItemDTO]>()
    let specialPerfumes = PublishSubject<[PerfumeDTO]>()
    let recommendPerfumes = PublishSubject<[PerfumeDTO]>()
    let recommendAccords = PublishSubject<[AccordDTO]>()
    let popularBrands = PublishSubject<[BrandDTO]>()

    let usecase: HomeUseCaseProtocol
    var disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()

        return output
    }
    
    init(usecase: HomeUseCaseProtocol) {
        self.usecase = usecase
    }
    
    // TODO: - 정보업데이트

    func updateHomeInfo() {
        usecase.getHomeInfo()
            .subscribe(onSuccess: { [weak self] info in
                self?.homeInfo.onNext(info)
                self?.bannerInfo.onNext(info.top_rolling_banner.list)
                self?.specialPerfumes.onNext(info.special_perfumes.list)
                self?.recommendPerfumes.onNext(info.recommend_perfumes.list)
                self?.recommendAccords.onNext(info.recommend_accords.list)
                self?.popularBrands.onNext(info.popular_brands.list)
            }, onFailure: { error in
                print("HomeVM에러 발생: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
