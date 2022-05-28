//
//  FavouritesRouter.swift
//  sello
//
//

import UIKit

final class FavouritesRouter: RouterType {
    private let router: Router

    init(transitionHandler: UIViewController) {
        router = Router(transitionHandler: transitionHandler)
    }

    func pop() {
        router.pop()
    }
}
