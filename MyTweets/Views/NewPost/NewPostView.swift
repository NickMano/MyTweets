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
    case openCamera
}

protocol NewPostViewProtocol: UIView {
    func addButtonAction(_ action: Selector, for button: NewPostButtons, from vc: UIViewController)
    func getPostText() -> String
    func setImage(_ image: UIImage)
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
        }
    }
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var openCameraButton: UIButton!
}

extension NewPostView: NewPostViewProtocol {
    func addButtonAction(_ action: Selector, for button: NewPostButtons, from vc: UIViewController) {
        switch button {
        case .cancel:
            cancelButton.addTarget(vc, action: action, for: .touchUpInside)
        case .post:
            postButton.addTarget(vc, action: action, for: .touchUpInside)
        case .openCamera:
            openCameraButton.addTarget(vc, action: action, for: .touchUpInside)
        }
    }
    
    func getPostText() -> String { textBox.text }
    
    func setImage(_ image: UIImage) {
        previewImageView.isHidden = false
        previewImageView.image = image
    }
}
