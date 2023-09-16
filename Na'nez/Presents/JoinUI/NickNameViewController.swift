//
//  NickNameViewController.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/28.
//


import UIKit
//import DropDown

class NickNameViewController: UIViewController {
    
    let nickNameView = NickNameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"

        view.addSubview(nickNameView)
        nickNameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nickNameView.topAnchor.constraint(equalTo: view.topAnchor),
            nickNameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nickNameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nickNameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        nickNameView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }
    

    

    @objc func backButtonTapped() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    //연령대 선택으로 넘어감
    @objc func nextButtonTapped() {
        let vc = FavoriteScentViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}


