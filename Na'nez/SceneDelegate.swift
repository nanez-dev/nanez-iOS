//
//  SceneDelegate.swift
//  Na'nez
//
//  Created by 최지철 on 2023/07/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
          window = UIWindow(windowScene: windowScene)
        
//        let HomeVC = SearchViewController(viewModel: SearchViewModel(usecase: SearchUseCase(repository: SearchRepository(service: PerfumeService()))))
//        window?.rootViewController = HomeVC
        
        
        let tabController = TabController()
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        
        
        
//        let HomeVC = RecommendLoginViewController()
//        let navigationController = UINavigationController(rootViewController: HomeVC)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

