//
//  AccountRouter.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


protocol AccountRouting {
    func showLogin() -> Void
    func showSignup() -> Void
}


class AccountRouter {
    
    private let viewController: UIViewController
    
    private let onLogin: (_ user: User?) -> Void
    
    typealias Submodules = (
        loginModule: (_ switchSignUp: @escaping () -> Void, @escaping (_ user: User?) -> Void) -> UIViewController,
        signUpModule: (_ switchLogin: @escaping () -> Void) -> UIViewController
    )
    
    private let submodules: Submodules
    
    private lazy var loginView = self.submodules.loginModule({ [weak self] in
        self?.showSignup()
        
    }) { [weak self] user in
        self?.onLogin(user)
    }
    
    private lazy var signUpView = self.submodules.signUpModule { [weak self] in
        self?.showLogin()
    }
    
    init(viewController: UIViewController, submodules: Submodules, onLogin: @escaping (_ user: User?) -> Void) {
        self.viewController = viewController
        self.submodules = submodules
        self.onLogin = onLogin
    }
}


extension AccountRouter: AccountRouting {
    
    func showLogin() {
        remove(asChildViewController: signUpView)
        add(asChildViewController: loginView, direction: .transitionFlipFromLeft)
    }
    
    func showSignup() {
        remove(asChildViewController: loginView)
        add(asChildViewController: signUpView, direction: .transitionFlipFromRight)
    }

}


private extension AccountRouter {
    
    func add(asChildViewController childController: UIViewController, direction: UIView.AnimationOptions) -> Void {
        viewController.addChild(childController)
        UIView.transition(with: viewController.view, duration: 0.3, options: direction,animations: {
            [viewController] in viewController.view.addSubview(childController.view)
        },completion: nil)
        
        childController.view.frame = viewController.view.bounds
        childController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childController.didMove(toParent: viewController)
    }
    
    func remove(asChildViewController childController: UIViewController) -> Void {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}
