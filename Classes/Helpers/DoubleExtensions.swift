//
//  DoubleExtensions.swift
//  sello
//
//

import Foundation

extension Double {
    func toStringComma() -> String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".", with: ",")
    }
}
