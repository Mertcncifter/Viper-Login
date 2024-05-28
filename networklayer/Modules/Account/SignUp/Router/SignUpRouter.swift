//
//  SignUpRouter.swift
//  networklayer
//
//  Created by mert can çifter on 14.05.2024.
//

import UIKit

protocol SignUpRouting {
    func routeToLogin() -> Void
}

class SignUpRouter {
    
    var viewController: UIViewController
    private let switchLogin: () -> Void
    init(viewController: UIViewController, switchLogin: @escaping () -> Void) {
        self.viewController = viewController
        self.switchLogin = switchLogin
    }
}


extension SignUpRouter: SignUpRouting {
    
    func routeToLogin() {
        self.switchLogin()
    }
    
    
}
