//
//  APIError.swift
//  sello
//
//

import Foundation

struct APIError: LocalizedError {
    
    private let _description: String
    let code: String
    let fieldErrors: [FieldError]
    let customPayload: CustomStringConvertible?
    
    var errorDescription: String? {
        if let customMessage = customPayload?.description {
            return customMessage
        }
        if _description.isEmpty {
            return fieldedDescription()
        }
        return _description
    }
    
    static func failure(reason: String, fieldErrors: [FieldError] = []) -> APIError {
        return APIError(reason, ErrorCode.custom.rawValue, fieldErrors)
    }
    
    static func failure(reasons: [String]) -> APIError {
        let fullReason = reasons
            .filter { !$0.isEmpty }
            .map { $0 + "." }
            .joined(separator: "\n\n")
        return APIError.failure(reason: fullReason)
    }
    
    private init(_ description: String, _ code: String, _ fieldErrors: [FieldError] = [], customPayload: CustomStringConvertible? = nil) {
        self._description = description
        self.fieldErrors = fieldErrors
        self.code = code
        self.customPayload = customPayload
    }

    private func fieldedDescription() -> String {
        let fieldDescriptions = fieldErrors.map { $0.description }.filter { !$0.isEmpty }

        return fieldDescriptions.reduce(_description) { result, field in
            var result = result
            if !result.isEmpty {
                result += "\n"
            }
            return result + field
        }
    }
}

struct FieldError {
    
    let errorCode: String
    let fieldCode: String
    let description: String
    let result: JSON?
    
    init(
        errorCode: String = .empty,
        fieldCode: String,
        description: String,
        result: JSON? = nil
    ) {
        self.errorCode = errorCode
        self.fieldCode = fieldCode
        self.description = description
        self.result = result
    }
}

extension APIError: Equatable {

    private enum ErrorCode: String {

        case custom = "CUSTOM_ERROR"
        case authRequired = "AUTH_REQUIRED"
        case empty = "EMPTY"
        case inProcessing = "IN_PROCESSING"
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        
        let rCode = ErrorCode(rawValue: lhs.code)
        let lCode = ErrorCode(rawValue: rhs.code)
        if lCode == .empty || rCode == .empty {
            return false
        }
        if lCode == .custom || rCode == .custom {
            return false
        }
        return lhs.code == rhs.code
    }
}
