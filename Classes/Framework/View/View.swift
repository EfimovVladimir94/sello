//
//  View.swift
//  mobile bank
//
//  Created by Andrey Chernyshev on 06.10.16.
//  Copyright © 2016 Simbirsoft. All rights reserved.
//

import UIKit
import RxSwift

protocol HasEmptyInitialization {
    init()
}

protocol ViewType: HasEmptyInitialization {

    associatedtype ViewModel: ViewModelType
    
    var bindings: ViewModel.Bindings { get }
    
    func bind(to viewModel: ViewModel)
    
    static func make() -> Self
}

extension ViewType {

    static func make() -> Self {
        return Self.init()
    }
}

extension ViewType where ViewModel.Bindings == Void {
    var bindings: Void {
        return ()
    }
}

// MARK: - Legacy

protocol BindsToViewModel: ViewType where
    ViewModel: HasEmptyInitialization,
    ViewModel.Bindings == Void,
    ViewModel.Routes.TransitionHandler == UIViewController {

    associatedtype Input
    associatedtype Output

    @discardableResult
    func bind(to viewModel: ViewModel, _ configuration: Input) -> Output
}

extension BindsToViewModel {
    func bind(to viewModel: ViewModel) {}
}

protocol HasDependenciesInitialization {

    associatedtype Dependencies
    init(_ dependencies: Dependencies)
}

protocol BindsToViewModelWithDependencies {
    
    associatedtype ViewModel: HasDependenciesInitialization
    associatedtype Dependencies
    associatedtype Input
    associatedtype Output
    
    @discardableResult
    func bind(to viewModel: ViewModel, _ input: Input, _ dependencies: Dependencies) -> Output

    static func make() -> Self
}

protocol HasDisposeBag {
    var disposeBag: DisposeBag { get }
}

class ViewController<RouterType, ViewModelType: ViewModel<RouterType>>: UIViewController {
    
    var viewModel: ViewModelType!
    
    func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(isNavigationBarHidden(), animated: true)
        navigationItem.largeTitleDisplayMode = .never
        super.viewWillAppear(animated)
    }
    
    deinit {
        print(String(describing: self) + " deallocated")
    }
    
    func isNavigationBarHidden() -> Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class SEViewController: UIViewController {
    
    func isNavigationBarHidden() -> Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(isNavigationBarHidden(), animated: animated)
        super.viewWillAppear(animated)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        print(String(describing: self) + " deallocated")
    }
}
