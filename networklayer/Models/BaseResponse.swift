//
//  BaseResponse.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import Foundation


struct BaseResponse<T: Codable>: Codable {
    var success: Bool
    var data: T?
    var message: String?
}
