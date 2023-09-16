//
//  FavoriteScentViewController.swift
//  Na'nez
//
//  Created by Gahyun Kim on 2023/09/17.
//



import UIKit
//import DropDown

class FavoriteScentViewController: UIViewController {
    
    let favoritescentView = FavoriteScentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "회원가입"

        view.addSubview(favoritescentView)
        favoritescentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favoritescentView.topAnchor.constraint(equalTo: view.topAnchor),
            favoritescentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritescentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritescentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        favoritescentView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
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


