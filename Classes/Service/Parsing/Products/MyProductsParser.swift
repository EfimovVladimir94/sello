//
//  MyProductsParser.swift
//  sello
//
//

import Foundation

final class MyProductsParser: JSONParser<MyProducts> {
    
    override func parse(_ type: MyProducts.Type, rawData: JSON) throws -> MyProducts {
        MyProducts(
            product: Product(
                id: rawData["id"].stringValue,
                imageUrl: URL(string: rawData["image_url"].stringValue),
                name: rawData["products_name"].stringValue,
                amount: rawData["description"].double,
                description: rawData["description"].string
            ),
            status: MyProducts.Status(rawValue: rawData["status"].stringValue) ?? .none
        )
    }
}
