//
//  SignInViewModel.swift
//  sello
//
//

import RxSwift
import RxCocoa

struct SignInViewModel {
    
    let validatedCredentials: Signal<Void>
}

extension SignInViewModel: ViewModelType {
    
    typealias Routes = EmptyRouter
    
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
        
        let validatedCredentials = binding.didTapSubmitButton
            .compactMap { credentials -> Inputs? in
                guard let login = credentials.login,
                      let password = credentials.password,
                      !login.isEmpty,
                      !password.isEmpty
                else {
                    return nil
                }
                return Inputs(login: login, password: password)
            }
            .flatMap {
                dependency.authService.login(
                    login: $0.login ?? .empty,
                    password: $0.password ?? .empty
                )
                    .compactMap { $0.token }
            }
            .mapToVoid()
        
        return SignInViewModel(
            validatedCredentials: validatedCredentials
        )
    }
}
