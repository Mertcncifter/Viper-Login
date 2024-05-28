//
//  SignUpBuilder.swift
//  networklayer
//
//  Created by mert can çifter on 14.05.2024.
//

import UIKit

class SignUpBuilder {
    
    
    static func build(switchLogin: @escaping ()-> Void) -> UIViewController {
        
        let view = SignUpViewController()
        
        let interactor = SignUInteractor()
        let router = SignUpRouter(viewController: view, switchLogin: switchLogin)
        
        let presenter = SignUpPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
}
