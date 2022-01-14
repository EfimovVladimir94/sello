//
//  SignInRouter.swift
//  sello
//

import Foundation
import RxCocoa

final class SignInRouter: RouterType {
    
    private let router: Router
    
    init(transitionHandler: UIViewController) {
        router = Router(transitionHandler: transitionHandler)
    }
    
    func popToRootViewController() {
        router.show(MainViewScreenBuilder.self, inputs: .init())
    }
}
