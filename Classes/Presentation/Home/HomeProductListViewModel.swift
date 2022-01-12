//
//  HomeProductListViewModel.swift
//  sello
//
//  Created by user on 03.01.2022.
//

import RxSwift
import RxCocoa

struct HomeProductListViewModel {
    
    let disposables: Disposable
}

extension HomeProductListViewModel: ViewModelType {
    
    typealias Routes = SignInRouter
    
    struct Inputs {
    }
    
    struct Bindings {
    }
    
    struct Dependencies {
    }
    
    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> HomeProductListViewModel {
        
        return HomeProductListViewModel(
            disposables: CompositeDisposable(disposables: [])
        )
    }
}

