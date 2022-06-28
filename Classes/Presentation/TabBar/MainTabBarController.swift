//
//  MainTabBarController.swift
//  sello
//
//

import UIKit

final class MainTabBarScreenBuilder: ScreenBuilder {
    
    typealias VC = MainTabBarController
}

final class MainTabBarViewModel: ViewModelType, HasEmptyInitialization {}

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension MainTabBarController: ViewType {
    func bind(to viewModel: MainTabBarViewModel) {}
    
    typealias ViewModel = MainTabBarViewModel
}

private extension MainTabBarController {

    func configure() {
        view.backgroundColor = .white
        tabBar.isTranslucent = false
        
        let homeController = UINavigationController(
            rootViewController: HomeProductsScreenBuilder().build(
                .init()
            )
        )
        
        let favouriteController = MainNavigationController(
            rootViewController: FavouritesScreenBuilder().build(())
        )
        
        let myProductsController = MainNavigationController(
            rootViewController: MyProductsScreenBuilder().build(())
        )
        
        let chatViewController = MainNavigationController(
            rootViewController: ChatMainScreenBuilder().build(())
        )
        
        let profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .green
        profileViewController.tabBarItem.title = R.string.localizable.tabbar_profile()
        profileViewController.tabBarItem.image = R.image.profile()
        profileViewController.tabBarItem.image?.withTintColor(.lightGray)
        
        viewControllers = [
            homeController,
            favouriteController,
            myProductsController,
            chatViewController,
            profileViewController
        ]
        
        selectedViewController = homeController
    }

}
