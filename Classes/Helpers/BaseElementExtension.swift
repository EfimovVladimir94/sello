//
//  BaseElementExtension.swift
//  sello
//
//

import UIKit

extension CAGradientLayer {
    
    func configMainBackground(view: UIView) -> CAGradientLayer {
        CAGradientLayer().setup {
            $0.colors = [
                UIColor.colorBottom.cgColor,
                UIColor.colorTop.cgColor
            ]
            $0.locations = [0, 1]
            $0.startPoint = CGPoint(x: 1, y: 0.25)
            $0.endPoint = CGPoint(x: 0.75, y: 0.75)
        }
    }
}
