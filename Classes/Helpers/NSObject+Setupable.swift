//
//  NSObject+Setupable.swift
//  sello
//

import Foundation

extension NSObject: Setupable {}

protocol Setupable {}

extension Setupable {
    
    @discardableResult
    func setup(closure: ((Self) -> Void)) -> Self {
        closure(self)
        return self
    }
}
