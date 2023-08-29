//
//  SelectSexViewController.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/08/25.
//


import UIKit
//import DropDown

class SelectSexViewController: UIViewController {
    
    let selectSexView = SelectSexView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"

        view.addSubview(selectSexView)
        selectSexView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectSexView.topAnchor.constraint(equalTo: view.topAnchor),
            selectSexView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectSexView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectSexView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        selectSexView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }
    

    

    @objc func backButtonTapped() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    //연령대 선택으로 넘어감
    @objc func nextButtonTapped() {
        let vc = SelectAgeViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}


