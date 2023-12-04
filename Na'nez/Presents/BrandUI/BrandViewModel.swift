//
//  BrandtubeViewModel.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/22.
//

import Foundation
import RxSwift

class BrandViewModel:ViewModelType {
    
    var disposeBag = DisposeBag()
    let usecase: BrandUseCaseProtocol
    let brands = PublishSubject<[BrandDTO]>()
    let populars = PublishSubject<[BrandDTO]>()
    let detail = PublishSubject<DetailBrandDTO>()
    let brandPerfumes = PublishSubject<[BrandPerfumeDTO?]>()
 
    struct Input{
        
    }
    
    struct Output{
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    init(usecase: BrandUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func updateAllBrands() {
        usecase.getAllBrand()
            .subscribe(
                onSuccess: { [weak self] list in
                    self?.brands.onNext(list.brands)
            },
                onFailure: { error in
                    print("BrandtubeVM에러:\(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func upadatePopularBrand() {
        usecase.getPopularBrand()
            .subscribe(
                onSuccess: { [weak self] list in
                    self?.populars.onNext(list.brands)
            },
                onFailure: { error in
                    print("BrandtubeVM에러:\(error)")
                }
            )
            .disposed(by: disposeBag)
    }
    
    func upadateBrandDetail(id: Int,limit: Int) {
        usecase.getDetailBrandInfo(with: id, with: limit)
            .subscribe(
                onSuccess: { [weak self] info in
                    self?.detail.onNext(info)
                    self?.brandPerfumes.onNext(info.relative_perfumes)
            },
                onFailure: { error in
                    print("BrandtubeVM에러:\(error)")
                }
            )
            .disposed(by: disposeBag)
    }
}
