//
//  UserService.swift
//  networklayer
//
//  Created by mert can çifter on 20.05.2024.
//

import Foundation


struct UserService {

    static let shared = UserService()
    
    func fetchUser(onCompletion: @escaping (BaseResponse<User>?,NetworkError?) -> ()) {
        
        
        APIRequestManager.makeGetRequest(path: "Product/fetchproducts", queries:  [:]) {(result: BaseResponse<User>?,error) in
            onCompletion(result,error)
        }
    }
}
