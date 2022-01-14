//
//  FontExtension.swift
//  sello
//
//

import UIKit

extension UIFont {
    
    // MARK: - Regular
    static func systemRegular(of size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .regular)
    }
    
    static var systemRegular11: UIFont {
        return .systemRegular(of: 11)
    }
    
    static var systemRegular12: UIFont {
        return .systemRegular(of: 12)
    }
    
    static var systemRegular13: UIFont {
        return .systemRegular(of: 13)
    }
    
    static var systemRegular15: UIFont {
        return .systemRegular(of: 15)
    }
    
    static var systemRegular17: UIFont {
        return .systemRegular(of: 17)
    }
    
    static var systemRegular150: UIFont {
        return .systemRegular(of: 150)
    }
    
    static func systemMedium(of size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .medium)
    }
    
    static func systemLight(of size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .light)
    }
    
    static func systemBold(of size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .bold)
    }
    
    static var systemBold15: UIFont {
        return .systemBold(of: 15)
    }
    
    static var systemMedium150: UIFont {
        return .systemMedium(of: 150)
    }
}
