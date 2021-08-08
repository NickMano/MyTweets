//
//  NewPostViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 26/06/2021.
//

import UIKit
import FirebaseStorage

protocol NewPostViewModelProtocol {
    func savePost(_ text: String, imageUrl: String?, onCompletion: @escaping (Result<Post, Error>) -> Void)
    func uploadPhotoToFirebase(_ image: UIImage, onCompletion: @escaping (String?) -> Void)
}

final class NewPostViewModel: NewPostViewModelProtocol {
    private let repository: PostRepositoryType
    
    init(repository: PostRepositoryType = PostRepository()) {
        self.repository = repository
    }
    
    func savePost(_ text: String, imageUrl: String?, onCompletion: @escaping (Result<Post, Error>) -> Void) {
        let request = PostRequest(text: text, imageUrl: imageUrl, videoUrl: nil)
        
        repository.savePost(request) { error in
            onCompletion(.failure(error))
        } onSuccess: { post in
            onCompletion(.success(post))
        }
    }
    
    func uploadPhotoToFirebase(_ image: UIImage, onCompletion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            onCompletion(nil)
            return
        }
        
        let metaDataConfig = StorageMetadata()
        metaDataConfig.contentType = "image/jpg"

        let storage = Storage.storage()
        let hash = setImageName()
        let route = storage.reference(withPath: "photos/photo-\(hash).jpg")
        
        route.putData(imageData, metadata: metaDataConfig) { metadata, error in
            self.onPutData(folder: route, error: error) { result in
                switch result {
                case .failure(_):
                    onCompletion(nil)
                case .success(let imageUrl):
                    onCompletion(imageUrl)
                }
            }
        }
    }
    
    private func setImageName() -> Int {
        let number = Int.random(in: 1...1000)
        var hasher = Hasher()
        
        hasher.combine("photo")
        hasher.combine(number)
        
        return hasher.finalize()
    }
    
    private func onPutData(folder: StorageReference ,error: Error?, onCompletion: @escaping (Result<String,Error>) -> Void ) {
        if let error = error {
            onCompletion(.failure(error))
        }
        
        self.donwloadUrlFrom(folder) { result in
            switch result {
            case .failure(let error):
                onCompletion(.failure(error))
            case .success(let downloadUrl):
                onCompletion(.success(downloadUrl))
            }
        }
    }
    
    private func donwloadUrlFrom(_ ref: StorageReference, onCompletion: @escaping (Result<String, Error>) -> Void) {
        ref.downloadURL { url, error in
            if let error = error {
                onCompletion(.failure(error))
            }
            
            guard let downloadUrl = url?.absoluteString else {
                onCompletion(.failure(PostError.badUrl))
                return
            }
            
            onCompletion(.success(downloadUrl))
        }
    }
}

enum PostError: Error {
    case badUrl
    case noImage
}
