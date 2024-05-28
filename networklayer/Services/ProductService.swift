//
//  ProductService.swift
//  networklayer
//
//  Created by mert can çifter on 27.05.2024.
//

import Foundation




struct ProductService {

    static let shared = ProductService()
    
    func fetchProducts(pageNumber: Int, pageSize: Int, onCompletion: @escaping (BaseResponse<[Product]>?,NetworkError?) -> ()) {
        
        var queries = ["pageNumber": pageNumber, "pageSize": pageSize]

        APIRequestManager.makeGetRequest(path: "Product/fetchproducts", queries: queries) {(result: BaseResponse<[Product]>?,error) in
            onCompletion(result,error)
        }
    }
}
