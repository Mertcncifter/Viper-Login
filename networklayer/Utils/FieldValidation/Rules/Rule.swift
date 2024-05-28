//
//  Rule.swift
//  networklayer
//
//  Created by mert can çifter on 15.05.2024.
//

import Foundation


protocol Rule {
    func validate(value: String) -> Bool
    func errorMessage() -> String
}
