//
//  ViewModelType.swift
//  Na'nez
//
//  Created by 최지철 on 2023/11/16.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
