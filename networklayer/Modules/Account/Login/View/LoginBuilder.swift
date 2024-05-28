//
//  LoginBuilder.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import UIKit


class LoginBuilder {
    
    
    static func build(switchSignUp: @escaping () -> Void, onLogin: @escaping (_ user: User?) -> Void) -> UIViewController {
        let view = LoginViewController()
        
        let interactor = LoginInteractor()
        let router = LoginRouter(viewController: view,switchSignUp: switchSignUp, onLogin: onLogin)
        
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
}
