//
//  SurveyViewModel.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/6/23.
//

import Foundation
import RxSwift
import RxCocoa

class SurveyViewModel {
    private let surveyView = SurveyView()
    private var selectedButtonIndex: BehaviorSubject<Int?> = BehaviorSubject(value: nil)
    private let disposeBag = DisposeBag()
    
    var selectedButtonId: Observable<Int?> {
        return selectedButtonIndex
            .map { [weak self] index in
                guard let index = index else { return nil }
                return self?.surveyView.incenseButtonInfo[index].id
            }
    }
    
    var selectedButton: Observable<Int?> {
        return selectedButtonIndex.asObservable()
    }
    
    var isButtonSelected: Observable<Bool> {
        return selectedButtonIndex.map { $0 != nil }
    }
    
    func selectButton(at index: Int) {
        if let currentIndex = try? selectedButtonIndex.value(), currentIndex == index {
            selectedButtonIndex.onNext(nil)
        }
        else {
            selectedButtonIndex.onNext(index)
        }
    }
}
