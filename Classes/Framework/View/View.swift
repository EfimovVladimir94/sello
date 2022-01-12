//
//  View.swift
//
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
