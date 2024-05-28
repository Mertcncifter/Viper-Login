//
//  ProductBuilder.swift
//  networklayer
//
//  Created by mert can çifter on 27.05.2024.
//

import UIKit



class ProductBuilder {
    
    
    static func build() -> UIViewController {
        
        let view = ProductViewController()
        
        let interactor = ProductInteractor()
        let router = ProductRouter(viewController: view)
        
        let presenter = ProductPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
}
