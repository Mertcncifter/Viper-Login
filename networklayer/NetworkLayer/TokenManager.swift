//
//  TokenManager.swift
//  networklayer
//
//  Created by mert can çifter on 20.05.2024.
//

import Foundation


class TokenManager {
    static let shared = TokenManager()
    
    private init() {}
    
    
    func getJWTToken() -> String? {
        return UserDefaults.token
    }
    
    func getRefreshToken() -> String? {
        return UserDefaults.refreshToken
    }
    
    
    func refreshJWTToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = self.getRefreshToken() else {
            completion(false)
            return
        }
        
        let refreshEndpoint = ""
        var request = URLRequest(url: URL(string: refreshEndpoint)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["token": refreshToken]
        if let jsonData = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = jsonData
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let responseData = data else {
                completion(false)
                NotificationCenter.default.post(name: .didFailToRefreshToken, object: nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                   let data = json["data"] as? [String: Any],
                   let newToken = data["accessToken"] as? String,
                   let refreshToken = data["refreshToken"] as? String {
                    UserDefaults.token = newToken
                    UserDefaults.refreshToken = refreshToken
                    completion(true)
                } else {
                    completion(false)
                    NotificationCenter.default.post(name: .didFailToRefreshToken, object: nil)
                }
            } catch {
                completion(false)
                NotificationCenter.default.post(name: .didFailToRefreshToken, object: nil)
            }
        }.resume()
    }
}

extension Notification.Name {
    static let didFailToRefreshToken = Notification.Name("didFailToRefreshToken")
}
