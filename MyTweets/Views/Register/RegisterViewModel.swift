//
//  RegisterViewModel.swift
//  MyTweets
//
//  Created by Nicolas Manograsso on 03/08/2021.
//

import Foundation

protocol RegisterViewModelType {
    func isValidForm(userName: String?, password pass: String?,
                     email: String?) -> (isValid: Bool, error: FormNotification?)
    
    func register(_ user: RegisterRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void)
}

final class RegisterViewModel: RegisterViewModelType {
    private let repository: UserRepositoryType
    
    init(repository: UserRepositoryType = UserRepository()) {
        self.repository = repository
    }
    
    func isValidForm(userName: String?,
                     password pass: String?,
                     email: String?) -> (isValid: Bool, error: FormNotification?) {
        guard let userName = userName,
              let pass = pass,
              let email = email else {
            return(false, .generic)
        }
        
        if userName.isEmpty && pass.isEmpty && email.isEmpty {
            return (false, .allFields)
        }
        
        if userName.isEmpty || pass.isEmpty || email.isEmpty {
            return (false, .someField)
        }
        
        return (true, nil)
    }
    
    func register(_ user: RegisterRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        repository.register(user) { error in
            onError(error)
        } onSuccess: {
            onSuccess()
        }
    }
}
