//
//  SelectEmailViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 11/27/23.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SelectEmailViewController: UIViewController {
    
    let selectEmailView = SelectEmailView()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(selectEmailView)
        selectEmailView.translatesAutoresizingMaskIntoConstraints = false
        
        selectEmailView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }

}
