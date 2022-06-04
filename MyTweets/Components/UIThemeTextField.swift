//
//  UIThemeTextField.swift
//  MyTweets
//
//  Created by nicolas.e.manograsso on 02/06/2022.
//

import Foundation
import UIKit

final class UIThemeTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .inputBackground
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .inputBackground
    }
}
