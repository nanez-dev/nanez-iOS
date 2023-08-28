//
//  SelectAgeViewController.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/28.
//

import UIKit
//import DropDown

class SelectAgeViewController: UIViewController {
    
    let selectAgeView = SelectAgeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"

        view.addSubview(selectAgeView)
        selectAgeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectAgeView.topAnchor.constraint(equalTo: view.topAnchor),
            selectAgeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectAgeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectAgeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        selectAgeView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }
    

    

    @objc func backButtonTapped() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    //닉네임 결정으로 넘어감
    @objc func nextButtonTapped() {
        let vc = NickNameViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}


