//
//  FavouritesProductsParser.swift
//  sello
//
//

import Foundation

final class ProductParser: JSONParser<Product> {
    
    override func parse(_ type: Product.Type, rawData: JSON) throws -> Product {
        Product(
            id: rawData["id"].stringValue,
            imageUrl: URL(string: rawData["image_url"].stringValue),
            name: rawData["products_name"].stringValue,
            amount: rawData["description"].double,
            description: rawData["description"].string
        )
    }
}
