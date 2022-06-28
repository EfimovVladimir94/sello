//
//  ChatMainViewModel.swift
//  sello
//
//

import RxSwift
import RxCocoa


struct ChatMainViewModel {

    let sections: Driver<[MyProducts]>
    let disposables: Disposable
}

extension ChatMainViewModel: ViewModelType {

    typealias Routes = MyProductsRouter

    struct Bindings {
    }

    struct Dependencies {
        let productsService: ProductsService
    }

    static func configure(
        input: Void,
        binding: Bindings,
        dependency: Dependencies,
        router: Routes
    ) -> ChatMainViewModel {

        let sections = dependency.productsService.loadMyProducts()
            .asDriver(onErrorDriveWith: .just([]))

        return ChatMainViewModel(
            sections: sections,
            disposables: CompositeDisposable(disposables: [])
        )
    }
}

