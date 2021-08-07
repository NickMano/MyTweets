//
//  LoginViewModel.swift
//  MyTweets
//
//  Created by nicolas.e.manograsso on 07/08/2021.
//

import Foundation

protocol LoginViewModelType {
    func isValidForm(password pass: String?, email: String?) -> (isValid: Bool, error: FormNotification?)
    
    func login(_ user: LoginRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void)
}

final class LoginViewModel: LoginViewModelType {
    private let repository: UserRepositoryType
    
    init(repository: UserRepositoryType = UserRepository()) {
        self.repository = repository
    }
    
    func isValidForm(password pass: String?, email: String?) -> (isValid: Bool, error: FormNotification?) {
        guard let pass = pass, let email = email else {
            return(false, .generic)
        }
        
        if pass.isEmpty && email.isEmpty {
            return (false, .allFields)
        }
        
        if pass.isEmpty || email.isEmpty {
            return (false, .someField)
        }
        
        return (true, nil)
    }
    
    func login(_ user: LoginRequest, onError: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        repository.login(user) { error in
            onError(error)
        } onSuccess: {
            onSuccess()
        }
    }
}
