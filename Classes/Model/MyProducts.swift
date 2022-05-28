//
//  MyProducts.swift
//  sello
//
//

import Foundation

struct MyProducts: Model {
    
    static var parser: Any {
        return MyProductsParser()
    }
    
    enum Status: String {
        case active = "ACTIVE"
        case archive = "ARCHIVE"
        case none = "NONE"
    }
    
    let product: Product
    let status: Status
}
