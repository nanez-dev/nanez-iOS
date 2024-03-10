//
//  ChangePwViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 2/27/24.
//

import UIKit
import SnapKit
import Then
import RxSwift

class ChangePwViewController: UIViewController {
    private let checkPwView = CheckPwView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "비밀번호 변경"
        setupChangePwView()
    }
    
    private func setupChangePwView() {
        view.addSubview(checkPwView)
        checkPwView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
