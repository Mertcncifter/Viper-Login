//
//  UserDefaults+Extension.swift
//  networklayer
//
//  Created by mert can çifter on 16.05.2024.
//

import Foundation


extension UserDefaults {

    @UserDefault(key: "token", defaultValue: nil)
    static var token: String?
    
    @UserDefault(key: "refreshToken", defaultValue: nil)
    static var refreshToken: String?
}
