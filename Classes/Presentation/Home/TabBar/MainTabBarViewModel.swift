//
//  MainTabBarViewModel.swift
//  sello
//
//

import RxSwift
import RxCocoa

struct MainTabBarViewModel {
    
    let disposables: Disposable
}

extension MainTabBarViewModel: ViewModelType {
    
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
    ) -> MainTabBarViewModel {
        
        
        return MainTabBarViewModel(
            disposables: CompositeDisposable(disposables: [])
        )
    }
}
