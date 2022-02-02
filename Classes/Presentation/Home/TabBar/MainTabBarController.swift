//
//  MainTabBarController.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit
import PinLayout

final class MainTabBarScreenBuilder: ScreenBuilder {
    
    typealias VC = MainTabBarController
    
    var dependencies: VC.ViewModel.Dependencies {
        .init()
    }
}

final class MainTabBarController: UITabBarController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension MainTabBarController: ViewType {
    var bindings: MainTabBarViewModel.Bindings {
        .init()
    }
    
    func bind(to viewModel: MainTabBarViewModel) {
    }
    
    
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
        
        let favouriteController = UIViewController()
        favouriteController.view.backgroundColor = .blue
        favouriteController.tabBarItem.title = R.string.localizable.tabbar_favourite()
        favouriteController.tabBarItem.image = R.image.love()
        favouriteController.tabBarItem.image?.withTintColor(.lightGray)
        
        let annonceViewController = UIViewController()
        annonceViewController.view.backgroundColor = .red
        annonceViewController.tabBarItem.title = R.string.localizable.tabbar_annonce()
        annonceViewController.tabBarItem.image = R.image.plus()
        annonceViewController.tabBarItem.image?.withTintColor(.lightGray)
        
        let chatViewController = UIViewController()
        chatViewController.view.backgroundColor = .yellow
        chatViewController.tabBarItem.title = R.string.localizable.tabbar_chat()
        chatViewController.tabBarItem.image = R.image.chat()
        chatViewController.tabBarItem.image?.withTintColor(.lightGray)
        
        let profileViewController = UIViewController()
        profileViewController.view.backgroundColor = .green
        profileViewController.tabBarItem.title = R.string.localizable.tabbar_profile()
        profileViewController.tabBarItem.image = R.image.profile()
        profileViewController.tabBarItem.image?.withTintColor(.lightGray)
        
        viewControllers = [
            homeController,
            favouriteController,
            annonceViewController,
            chatViewController,
            profileViewController
        ]
        
        selectedViewController = homeController
    }
}
