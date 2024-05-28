//
//  ProductInteractor.swift
//  networklayer
//
//  Created by mert can çifter on 27.05.2024.
//

import Foundation


protocol ProductUseCase {

    func fetchProducts(pageNumber: Int, pageSize: Int, completion: @escaping (([Product]?,String?) -> (Void))) -> Void

}

class ProductInteractor {
    var service: ProductService = ProductService.shared
}


extension ProductInteractor: ProductUseCase {
    
    func fetchProducts(pageNumber: Int, pageSize: Int, completion: @escaping (([Product]?, String?) -> (Void))) {
        self.service.fetchProducts(pageNumber: pageNumber, pageSize: pageSize) { response, error in
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
