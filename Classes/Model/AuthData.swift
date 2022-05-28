//
//  AuthData.swift
//  sello
//
//  Created by user on 16.12.2021.
//

import Foundation

struct AuthData: Model {
    
    let token: String?
    
    static var parser: Any {
        AuthDataParser()
    }
}
