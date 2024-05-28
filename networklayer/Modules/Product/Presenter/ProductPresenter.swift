//
//  ProductPresenter.swift
//  networklayer
//
//  Created by mert can çifter on 27.05.2024.
//

import Foundation


protocol ProductPresentation {
    func viewDidLoad() -> Void
    func pagination() -> Void
}



class ProductPresenter {
    
    weak var view: ProductView?
    var interactor: ProductUseCase
    var router: ProductRouting
    
    var currentPage = 1
    var isLoading = false
    
    init(view: ProductView?, interactor: ProductUseCase, router: ProductRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension ProductPresenter: ProductPresentation {
    func viewDidLoad() {
        fetchProducts()
    }
    
    
    func fetchProducts() {
        guard !isLoading else { return }
        isLoading = true
        
        self.interactor.fetchProducts(pageNumber: currentPage, pageSize: 20) { data, error in
                        
            self.isLoading = false
            
            if let error = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            self.view?.updateProducts(products: data)
        }
    }
    
    func pagination() {
        currentPage += 1
        fetchProducts()
    }
    
 

   
    

}
