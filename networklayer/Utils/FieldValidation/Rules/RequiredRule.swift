//
//  RequiredRule.swift
//  networklayer
//
//  Created by mert can çifter on 15.05.2024.
//

import Foundation


open class RequiredRule: Rule  {

    private var message: String
    
    
    init(message: String = "Required") {
        self.message = message
    }
    
    func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    
    func errorMessage() -> String {
        return message
    }
}
