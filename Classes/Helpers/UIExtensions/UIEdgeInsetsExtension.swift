//
//  UIEdgeInsetsExtension.swift
//  sello
//
//  Created by user on 17.01.2022.
//

import UIKit

extension UIEdgeInsets {
    
    static func make(
        top: CGFloat? = nil,
        left: CGFloat? = nil,
        bottom: CGFloat? = nil,
        right: CGFloat? = nil
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: top ?? .zero,
            left: left ?? .zero,
            bottom: bottom ?? .zero,
            right: right ?? .zero
        )
    }
    
    static func all(
        inset: CGFloat
    ) -> UIEdgeInsets {
        .init(
            top: inset,
            left: inset,
            bottom: inset,
            right: inset
        )
    }
}
