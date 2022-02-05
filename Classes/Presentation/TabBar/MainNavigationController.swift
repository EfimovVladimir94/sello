//
//  MainNavigationController.swift
//  sello
//
//  Created by user on 05.02.2022.
//


import UIKit
import RxCocoa
import RxSwift

final class MainNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    private lazy var statusBarBackground = UIView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        view.backgroundColor = .clear
        let statusBarFrame = view.convert(
            view
                .window?
                .windowScene?
                .statusBarManager?
                .statusBarFrame ?? CGRect.init(),
            from: UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
        )
        
        statusBarBackground.frame = statusBarFrame
        delegate = self
        applyNavigationBarStyle(to: navigationBar)
        
        view.insertSubview(
            statusBarBackground,
            belowSubview: navigationBar
        )
    }
    
    func applyNavigationBarStyle(to navBar: UINavigationBar) {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.shadowColor = nil
            appearance.shadowImage = nil
            appearance.titleTextAttributes[.foregroundColor] = UIColor.white
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
        } else {
            navBar.barStyle = .black
            navBar.shadowImage = UIImage()
        }
        
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        
        let backgroundImage = R.image.rectangle()?.withRenderingMode(.alwaysOriginal)
        
        if #available(iOS 13.0, *) {
            navigationBar.standardAppearance.backgroundImage = backgroundImage
            navigationBar.standardAppearance.backgroundImageContentMode = .scaleToFill
            navigationBar.scrollEdgeAppearance?.backgroundImage = backgroundImage
            navigationBar.scrollEdgeAppearance?.backgroundImageContentMode = .scaleToFill
        } else {
            navigationBar.barTintColor = UIColor(patternImage: backgroundImage ?? UIImage())
        }
    }
}

