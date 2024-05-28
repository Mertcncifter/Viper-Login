//
//  ProductRouter.swift
//  networklayer
//
//  Created by mert can çifter on 27.05.2024.
//

import UIKit


protocol ProductRouting {

}

class ProductRouter {
    
    var viewController: UIViewController
    
    init(viewController: UIViewController)
    {
        self.viewController = viewController
    }
}


extension ProductRouter: ProductRouting {

    
    
}
