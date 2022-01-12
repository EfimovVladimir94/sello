//
//  Router.swift
//  sello
//

import UIKit

protocol RouterType {

    associatedtype TransitionHandler

    init(transitionHandler: TransitionHandler)
}

final class EmptyRouter: RouterType {
    required init(transitionHandler: UIViewController) {}
}

class Router {
    
    weak var viewController: UIViewController?
    private static weak var popToViewController: UIViewController?
    
    required init(transitionHandler: UIViewController) {
        self.viewController = transitionHandler
    }
    
    func pop() {
        if let popVC = Router.popToViewController {
            if let indexBehind = viewController?.navigationController?.viewControllers.firstIndex(of: popVC) {
                if indexBehind == 0 {
                    viewController?.navigationController?.popToViewController(popVC, animated: true)
                } else {
                    if let behindVC = viewController?.navigationController?.viewControllers[indexBehind - 1] {
                        viewController?.navigationController?.popToViewController(behindVC, animated: true)
                    }
                    else {
                        viewController?.navigationController?.popToViewController(popVC, animated: true)
                    }
                }
            }
            else {
                viewController?.navigationController?.popViewController(animated: true)
            }
            Router.popToViewController = nil
        }
        else {
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    func popToRootViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func pop(to targetViewController: UIViewController) {
        guard let navigationController = viewController?.navigationController else { return }
        navigationController.popToViewController(targetViewController, animated: true)
    }
}
