//
//  LoginInteractor.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import Foundation


protocol LoginUseCase {
    func login(username: String, password: String,completion: @escaping ((TokenModel?,String?) -> (Void))) -> Void
    func fetchUser(completion: @escaping ((User?,String?) -> (Void))) -> Void
}

class LoginInteractor {
    var service: AuthService = AuthService.shared
}


extension LoginInteractor: LoginUseCase {
    
    func login(username: String, password: String, completion: @escaping ((TokenModel?,String?) -> (Void))) {
        self.service.login(username: username, password: password) { response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            guard let data = response?.data else {
                completion(nil, "Warning Data")
                return
            }
            
            completion(data,nil)
        }
    }
    
    func fetchUser(completion: @escaping ((User?, String?) -> (Void))) {
        
        self.service.fetchUser { response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            guard let data = response?.data else {
                completion(nil, "Warning Data")
                return
            }
            
            completion(data,nil)
        }
    }
}
