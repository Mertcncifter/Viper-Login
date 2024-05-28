//
//  HomeViewBuilder.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


class TabBarViewBuilder {
    
    static func build(user: User?,onLogout: @escaping () -> Void) -> UITabBarController {
        
        guard let user = user else {
            return UITabBarController()
        }
        
        
        
        let submodules = (
            product: UINavigationController(rootViewController: ProductBuilder.build()),
            profile: UINavigationController(rootViewController: ProfileViewController(user: user,onLogout: onLogout))
        )
        
        
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let tabBarController = TabBarViewController(tabs: tabs)
        return tabBarController
        
    }
}
