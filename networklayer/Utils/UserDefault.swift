//
//  UserDefault.swift
//  networklayer
//
//  Created by mert can çifter on 16.05.2024.
//

import Foundation


@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value?
    var container: UserDefaults = .standard

    var wrappedValue: Value? {
        get {
            return container.object(forKey: key) as? Value
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
