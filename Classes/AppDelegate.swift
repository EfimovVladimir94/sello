//
//  AppDelegate.swift
//  sello
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let vc = SignInScreenBuilder.init()
            .build(.init(
                login: nil,
                password: nil
            ))
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}

