//
//  AuthParser.swift
//  sello
//
//

import Foundation

final class AuthDataParser: JSONParser<AuthData> {
    
    override func parse(_ type: AuthData.Type, rawData: JSON) throws -> AuthData {
        AuthData(token: rawData["token"].stringValue)
    }
}

