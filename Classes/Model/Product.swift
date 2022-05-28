//
//  FavouritesProducts.swift
//  sello
//
//

import Foundation

struct Product: Model {
    
    static var parser: Any {
        return ProductParser()
    }
    
    let id: String
    let imageUrl: URL?
    let name: String
    let amount: Double?
    let description: String?
}
