//
//  MyProductsRouter.swift
//  sello
//
//

import UIKit

final class MyProductsRouter: RouterType {
    private let router: Router

    init(transitionHandler: UIViewController) {
        router = Router(transitionHandler: transitionHandler)
    }

    func pop() {
        router.pop()
    }
}
