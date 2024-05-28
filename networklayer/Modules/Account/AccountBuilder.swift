//
//  AccountBuilder.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit



class AccountBuilder {
    
    static func build(onLogin: @escaping (_ user: User?) -> Void) -> UIViewController {
        let accountView = AccountViewController()
        
        let router = AccountRouter(viewController: accountView,
                                   submodules: (
                                        loginModule: LoginBuilder.build,
                                        signUpModule: SignUpBuilder.build
                                   ), onLogin: onLogin
        )
        let presenter = AccountPresenter(router: router)
        accountView.presenter = presenter
        presenter.view = accountView
        return accountView
    }
}
