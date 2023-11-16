//
//  TabController.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit
import SnapKit
import Then
class TabController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.delegate = self
        let vc1 = UINavigationController(rootViewController: HomeViewController(HomeViewModel(usecase: HomeUseCase(repository: HomeRepository(homeService: HomeService())))))
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc1.navigationBar.isHidden = true
        vc1.tabBarItem.image = UIImage(systemName: "house")
        let vc2 = UINavigationController(rootViewController: WishListViewController())
        vc2.tabBarItem.image = UIImage(systemName: "heart")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        vc2.navigationBar.isHidden = true
        let vc3 = UINavigationController(rootViewController: MyInfoViewController())
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        vc3.tabBarItem.image = UIImage(systemName: "person")
        vc3.navigationBar.isHidden = true

   
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        self.tabBar.clipsToBounds = true
        self.tabBar.tintColor = .mainturquoise

        self.tabBar.unselectedItemTintColor = .darkGray
        
        
        setViewControllers([vc1,vc2,vc3], animated: false)
    }


}
