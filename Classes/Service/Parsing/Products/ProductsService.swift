//
//  ProductsService.swift
//  sello
//
//

import Foundation
import RxSwift
import RxCocoa

final class ProductsService {
    
    func loadFavourites() -> Observable<[Product]> {
        let method = "v1/account/favourites"
        return JSONAPI.perform(method: method, requestType: .get)
            .map { json in
                return Parser().parseArray(Product.self, rawData: JSON(json))
            }
            .take(1)
    }
    
    func loadMyProducts() -> Observable<[MyProducts]> {
        .just([])
//        let method = "v1/account/myProducts"
//        return JSONAPI.perform(method: method, requestType: .get)
//            .map { json in
//                try? Parser().parse(MyProducts.self, rawData: JSON(json))
//            }
    }
}
