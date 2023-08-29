//
//  PasswordViewController.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/25.
//


import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {

    let passwordView = PassWordView()
    var passwordModel = PasswordModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"
        
        //setupNavigationBar()
        view.addSubview(passwordView)
        
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: view.topAnchor),
            passwordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            passwordView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       
        // Add the login and join button targets her
        passwordView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }



    @objc func backButtonTapped() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    //성별 선택으로 넘어감
    @objc func nextButtonTapped() {
        let vc = SelectSexViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

