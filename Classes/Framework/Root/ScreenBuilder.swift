//
//  ScreenBuilder.swift
//  sello
//
//

import RxSwift
import RxCocoa
import UIKit

protocol ScreenBuilder: HasEmptyInitialization {

    associatedtype VC : UIViewController & ViewType

    var dependencies: VC.ViewModel.Dependencies { get }
}

extension ScreenBuilder where VC.ViewModel.Dependencies == Void {
    var dependencies: VC.ViewModel.Dependencies {
        return ()
    }
}

extension ScreenBuilder {

    func build(
        _ inputs: VC.ViewModel.Inputs,
        transitions: VC.ViewModel.Routes.TransitionHandler
    ) -> VC {

        let vc = VC.make()
        vc.loadViewIfNeeded()

        let vm = VC.ViewModel.configure(
            input: inputs,
            binding: vc.bindings,
            dependency: dependencies,
            router: VC.ViewModel.Routes(transitionHandler: transitions)
        )

        vc.bind(to: vm)

        return vc
    }
}

extension ScreenBuilder where VC.ViewModel.Routes.TransitionHandler == UIViewController {

    func build(_ inputs: VC.ViewModel.Inputs) -> VC {

        let vc = VC.make()
        vc.loadViewIfNeeded()

        let vm = VC.ViewModel.configure(
            input: inputs,
            binding: vc.bindings,
            dependency: dependencies,
            router: VC.ViewModel.Routes(transitionHandler: vc)
        )

        vc.bind(to: vm)

        return vc
    }
}

extension Router {

    func show<Builder: ScreenBuilder>(
        _ type: Builder.Type,
        inputs: Builder.VC.ViewModel.Inputs,
        animated: Bool = true
    )
        where Builder.VC.ViewModel.Routes.TransitionHandler == UIViewController
    {
        let builder = Builder()
        let vc = builder.build(inputs)
        push(vc, animated: animated)
    }
    
    private func push(_ vc: UIViewController, animated: Bool = true) {
        guard let controller = viewController,
              let navController = controller.navigationController else {
            return
        }
        navController.pushViewController(vc, animated: animated)
    }
}
