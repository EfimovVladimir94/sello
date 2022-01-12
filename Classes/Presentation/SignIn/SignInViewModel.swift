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
        let login: String?
        let password: String?
    }
    
    struct Bindings {
        let didTapSubmitButton: Signal<Inputs>
    }
    
    struct Dependencies {
        let authService: AuthService
    }
    
    enum Constants {
        static let widthMargin: CGFloat = 40
        static let marginTop: CGFloat = 20
        static let extraMarginTop: CGFloat = 32
        static let height: CGFloat = 50
    }
    
    static func configure(
        input: Inputs,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> SignInViewModel {
        
        let didTapSubmitButton = binding.didTapSubmitButton
            .emit(onNext: { _ in
            router.popToRootViewController()
        })
        
        return SignInViewModel(
            disposables: CompositeDisposable(disposables: [didTapSubmitButton])
        )
    }
}
