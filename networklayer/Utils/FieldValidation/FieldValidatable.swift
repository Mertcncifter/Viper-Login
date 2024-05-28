//
//  FieldValidatable.swift
//  networklayer
//
//  Created by mert can çifter on 15.05.2024.
//

import Foundation


protocol FieldValidatable {
    var validationRules: [Rule] { get }
    var validationText: String { get }
}
