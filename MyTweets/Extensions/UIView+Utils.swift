//
//  UIView+Utils.swift
//  MyTweets
//
//  Created by nicolas.e.manograsso on 08/08/2021.
//

import UIKit

extension UIView {
    func addShadow (cornerRadius: CGFloat = 5) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
