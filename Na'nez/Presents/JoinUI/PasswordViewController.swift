//
//  PasswordViewController.swift
//  Na'nez
//
//  Created by KIM Hyung Jun on 12/3/23.
//

import UIKit
import SnapKit
import Then

class PasswordViewController: UIViewController {
    let passwordView = PasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        view.addSubview(passwordView)
        configure()
    }
    
    private func configure() {
        view.addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        passwordView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
}
