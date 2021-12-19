//
//  SignInViewModel.swift
//  sello
//
//

import RxSwift
import RxCocoa

struct SignInViewModel {
    
    let disposables: Disposable
}

extension SignInViewModel: ViewModelType {
    
    typealias Routes = SignInRouter
    
    struct Inputs {
        let login: Driver<String?>
        let password: Driver<String?>
    }
    
    struct Bindings {
        let didTapSubmitButton: Signal<Inputs>
    }
    
    struct Dependencies {
        let authService: AuthService
    }
    
    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> SignInViewModel {
        return SignInViewModel(
            disposables: CompositeDisposable(disposables: [])
        )
    }
}
