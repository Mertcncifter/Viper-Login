//
//  HomeRouter.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


struct TabBarRouter {
    
    var viewController: UIViewController
    
    typealias Submodules = (
        product: UIViewController,
        profile: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    
    static func tabs(usingSubmodules submodules: Submodules) -> Tabs {
        
        let productTabBarItem = UITabBarItem(title: "Products", image: UIImage(systemName: "list.dash"), tag: 1)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        submodules.product.tabBarItem = productTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        return (
            product: submodules.product,
            profile: submodules.profile
        )
    }
}

