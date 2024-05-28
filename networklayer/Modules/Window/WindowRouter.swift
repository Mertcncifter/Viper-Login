//
//  WindowRouter.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


protocol WindowRouting {
    func routeTo(kind: WindowRouter.Kind)
    func routeToLogin()
}

class WindowRouter {
    
    private unowned let window: UIWindow
    private var accountView: UIViewController?
    private var tabbarView: UIViewController?
    private let subModules: Submodules

    
    typealias Submodules = (
        accountModule: (_ onLogin: @escaping (_ user: User?) -> Void) -> UIViewController,
        tabbarModule: (_ user: User?, _ onLogout: @escaping () -> Void) -> UIViewController
    )
    
    enum Kind {
        case login
        case home(User)
    }
    
    init(_ window: Window, subModules: Submodules) {
        self.window = window
        self.subModules = subModules
        
        self.accountView = subModules.accountModule { [weak self] user in
            
            guard let self = self else { return }
            
            UIView.transition(with: self.window, duration: 0.3,options: .curveEaseIn) {
                self.tabbarView = self.subModules.tabbarModule(user, {
                    self.routeToLogin()
                })
                self.window.rootViewController = self.tabbarView
                self.window.makeKeyAndVisible()
            }
            
        }
        
        self.tabbarView = subModules.tabbarModule(nil, {
            self.routeToLogin()
        })
    }
}

extension WindowRouter: WindowRouting {
    
    func routeTo(kind: WindowRouter.Kind) {
        var viewController: UIViewController?
        switch kind {
        case .login:
            viewController = self.accountView
        case .home(let user):
            self.tabbarView = self.subModules.tabbarModule(user, {
                self.routeToLogin()
            })
            viewController = self.tabbarView
        }
        
        self.window.rootViewController = viewController
        self.window.makeKeyAndVisible()
    }
    
    func routeToLogin() {
        
        DispatchQueue.main.async {
            UIView.transition(with: self.window, duration: 0.3,options: .curveEaseIn) {
                self.window.rootViewController = self.accountView
                self.window.makeKeyAndVisible()
            }
        }
    }
   
}


