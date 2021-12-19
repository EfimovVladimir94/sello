//
//  ViewModel.swift
//  FIFA2018
//
//  Created by Andrey Chernyshev on 06.10.16.
//  Copyright © 2016 Simbirsoft. All rights reserved.
//

protocol ViewModelType {

    associatedtype Inputs = Void
    associatedtype Bindings = Void
    associatedtype Dependencies = Void
    associatedtype Routes: RouterType = EmptyRouter

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> Self
}

extension ViewModelType where Self: HasEmptyInitialization {

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> Self {
        return Self.init()
    }
}

extension ViewModelType where Self.Inputs == Self {

    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> Self {
        return input
    }
}

// MARK: - Legacy

class ViewModel<RouterType: Router> {
    
    var router: RouterType
    
    init(router: RouterType) {
        self.router = router
    }
    
    deinit {
        print(String(describing: self) + " deallocated")
    }
}

