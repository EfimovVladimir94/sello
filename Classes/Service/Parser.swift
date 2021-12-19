//
//  Parser.swift
//  sello
//
//

import Foundation
import SwiftyJSON

typealias JSON = SwiftyJSON.JSON

protocol RawData { }

extension JSON: RawData { }
extension Data: RawData { }

extension JSON: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawString())
    }
}

protocol Model {
    static var parser: Any { get }
}

class Parser<M: Model, R: RawData> {

    func parse(_ type: M.Type, rawData: R) throws -> M {
        switch rawData {
        case is JSON:
            return try (type.parser as! JSONParser).parse(type, rawData: rawData as! JSON)
        default:
            fatalError()
        }
    }

    func parseArray(_ type: M.Type, rawData: R) -> [M] {
        switch rawData {
        case is JSON:
            return (type.parser as! JSONParser).parseArray(type, rawData: rawData as! JSON)
        default:
            fatalError()
        }

    }
}

class JSONParser<M: Model> {

    func parseArray(_ type: M.Type = M.self, rawData: JSON) -> [M] {
        return rawData.compactMap {
            try? parse(type, rawData: $1)
        }
    }

    func parse(_ type: M.Type = M.self, rawData: JSON) throws -> M { fatalError() }

}
