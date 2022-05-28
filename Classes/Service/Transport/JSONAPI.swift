//
//  JSONAPI.swift
//  sello
//
//

import Foundation
import SwiftyJSON
import RxSwift

final class JSONAPI: API<JSON> {

    override class func parse(data: Data, response: HTTPURLResponse) -> Observable<(rawData: JSON, headers: [String : String])> {
        
        guard let json = try? JSON(data: data) else {
            return response.statusCode == 500
                ? .error(APIError.failure as! Error)
                : .error(APIError.failure as! Error)
        }
        let isSuccess = 200..<300 ~= response.statusCode

        var responseHeaders: [String: String] = [:]
        if let headers = response.allHeaderFields as? [String: String] {
            responseHeaders = headers
        }
        return Observable.just((json, responseHeaders))
    }
}
