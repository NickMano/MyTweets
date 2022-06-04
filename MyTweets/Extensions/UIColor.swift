//
//  UIColor.swift
//  MyTweets
//
//  Created by nicolas.e.manograsso on 02/05/2022.
//

import UIKit
import WolmoCore

extension UIColor {
    static var oxfordBlue: UIColor = UIColor(hex: "14203B") ?? .black
    static var independence: UIColor = UIColor(hex: "455879") ?? .black
    static var blueJeans: UIColor = UIColor(hex: "59B1F8") ?? .blue
}

extension UIColor {
    static var primaryColor: UIColor {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .oxfordBlue
            } else {
                return .white
            }
        }
    }
    
    static var secondaryColor: UIColor {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .independence
            } else {
                return .white
            }
        }
    }
    
    static var inputBackground: UIColor {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .independence
            } else {
                return .systemGray6
            }
        }
    }
    
    static var homeBackground: UIColor {
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            if UITraitCollection.userInterfaceStyle == .dark {
                return .oxfordBlue
            } else {
                return .systemGray6
            }
        }
    }
}
