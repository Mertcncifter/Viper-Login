//
//  WindowBuilder.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


class WindowBuilder {
    
    static func build(frame: CGRect) -> UIWindow {
        
        let window = Window(frame: frame)
        
        let router = WindowRouter(window, subModules: (
            accountModule: AccountBuilder.build,
            tabbarModule: TabBarViewBuilder.build
        ))
        
        let interactor = WindowInteractor()
        let presenter = WindowPresenter(router: router, interactor: interactor)
        
        window.presenter = presenter
        
        return window
        
    }
}

