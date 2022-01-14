//
//  MainHomeViewModel.swift
//  sello
//
//  Created by user on 03.01.2022.
//

import RxSwift
import RxCocoa

struct MainHomeViewModel {
    
    let disposables: Disposable
}

extension MainHomeViewModel: ViewModelType {
    
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
    ) -> MainHomeViewModel {
        
        return MainHomeViewModel(
            disposables: CompositeDisposable(disposables: [])
        )
    }
}

