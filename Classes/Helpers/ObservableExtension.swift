//
//  ObservableExtension.swift
//  sello
//
//

import RxSwift
import RxCocoa

extension ObservableType {

    func mapToVoid() -> Observable<Void> { mapTo(()) }
    func mapTo<T>(_ value: T) -> Observable<T> { map { _ in value } }
}

extension SharedSequence {

    func mapToVoid() -> SharedSequence<SharingStrategy, Void> { mapTo(()) }
    func mapTo<T>(_ value: T) -> SharedSequence<SharingStrategy, T> { map { _ in value } }
}

protocol OptionalType: ExpressibleByNilLiteral {
    associatedtype Wrapped
    var optional: Wrapped? { get }
    init(_ value: Wrapped)
}

extension SharedSequenceConvertibleType where Element: OptionalType {
    
    func filterNil() -> SharedSequence<SharingStrategy, Element.Wrapped>  {
        
        return flatMap { wrapped -> SharedSequence<SharingStrategy, Element.Wrapped> in
            if let unwrapped = wrapped.optional {
                return .just(unwrapped)
            }
            return .empty()
        }
    }
}
