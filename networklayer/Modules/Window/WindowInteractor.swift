//
//  WindowInteractor.swift
//  networklayer
//
//  Created by mert can çifter on 17.05.2024.
//

import Foundation


protocol WindowUseCase {
    func getUser(completion: @escaping ((User?,String?) -> (Void))) -> Void
}

class WindowInteractor {
    var service: AuthService = AuthService.shared
}


extension WindowInteractor: WindowUseCase {
    func getUser(completion: @escaping ((User?, String?) -> (Void))) {
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
