//
//  HomeCategoryViewModel.swift
//  sello
//
//

import RxSwift
import RxCocoa

struct HomeCategoryViewModel {
    
    let disposables: Disposable
}

extension HomeCategoryViewModel: ViewModelType {
    
    typealias Routes = SignInRouter
    
    struct Bindings {
        let didTapSubmitButton: Signal<Inputs>
    }
    
    struct Dependencies {
        let authService: AuthService
    }
    
    enum Constants {
        static let margin: CGFloat = 20
        static let marginTop: CGFloat = 60
        static let imageSize: CGFloat = 24
        static let inputHeight: CGFloat = 40
        static let height: CGFloat = 250
        static let collectionViewHeight: CGFloat = 120
    }
    
    static func configure(
        input: Void,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> HomeCategoryViewModel {
        
        _ = binding.didTapSubmitButton
            .emit(onNext: { _ in
            router.popToRootViewController()
        })
        
        return HomeCategoryViewModel(
            disposables: CompositeDisposable(disposables: [])
        )
    }
}
