//
//  MyProductsViewModel.swift
//  sello
//
//

import RxSwift
import RxCocoa

struct MyProductsViewModel {
    
    let items: Driver<[MyProducts]>
    let disposables: Disposable
}

extension MyProductsViewModel: ViewModelType {
    
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
    ) -> MyProductsViewModel {
        
        let items = dependency.productsService.loadMyProducts()
            .asDriver(onErrorDriveWith: .just([]))
        
        return MyProductsViewModel(
            items: items,
            disposables: CompositeDisposable(disposables: [])
        )
    }
}

