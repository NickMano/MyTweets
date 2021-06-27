//
//  NewPostView.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import UIKit

enum NewPostButtons {
    case cancel
    case post
}

protocol NewPostViewProtocol: UIView {
    func addButtonAction(_ action: Selector, for button: NewPostButtons, from vc: UIViewController)
    func getPostText() -> String
}

final class NewPostView: NibView {
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton! {
        didSet {
            postButton.layer.cornerRadius = 14
        }
    }
    
    @IBOutlet weak var textBox: UITextView! {
        didSet {
            textBox.layer.cornerRadius = 8
            textBox.backgroundColor = .lightGray
        }
    }
}

extension NewPostView: NewPostViewProtocol {
    func addButtonAction(_ action: Selector, for button: NewPostButtons, from vc: UIViewController) {
        switch button {
        case .cancel:
            cancelButton.addTarget(vc, action: action, for: .touchUpInside)
        case .post:
            postButton.addTarget(vc, action: action, for: .touchUpInside)
        }
    }
    
    func getPostText() -> String { textBox.text }
}
