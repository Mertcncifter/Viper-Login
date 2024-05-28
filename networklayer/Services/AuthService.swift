//
//  AuthService.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import Foundation


struct AuthService {

    static let shared = AuthService()
    
    func login(username: String, password: String, onCompletion: @escaping (BaseResponse<TokenModel>?,NetworkError?) -> ()) {
        
        let body: Parameters = ["username": username, "password": password]
        APIRequestManager.makePostRequest(path: "Authenticate/login", body: body) {(result: BaseResponse<TokenModel>?,error) in
            onCompletion(result,error)
        }
    }
    
    func fetchUser(onCompletion: @escaping (BaseResponse<User>?,NetworkError?) -> ()) {
        
        APIRequestManager.makeGetRequest(path: "User/GetUser", queries: [:]) {(result: BaseResponse<User>?,error) in
            onCompletion(result,error)
        }
    }
}
