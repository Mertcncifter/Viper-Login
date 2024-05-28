//
//  LoginRouter.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import UIKit


protocol LoginRouting {
    func routerToSignUp() -> Void
    func routeToWindow(user: User) -> Void
}

class LoginRouter {
    
    var viewController: UIViewController
    private let switchSignUp: () -> Void
    private let onLogin: (_ user: User?) -> Void
    
    init(viewController: UIViewController, 
         switchSignUp: @escaping () -> Void,
         onLogin: @escaping (_ user: User?) -> Void
    ) {
        self.viewController = viewController
        self.switchSignUp = switchSignUp
        self.onLogin = onLogin
    }
}


extension LoginRouter: LoginRouting {

    func routerToSignUp() {
        self.switchSignUp()
    }
    
    
    func routeToWindow(user: User) {
        self.onLogin(user)
    }
    
}
