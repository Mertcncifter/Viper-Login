//
//  SignUpPresenter.swift
//  networklayer
//
//  Created by mert can çifter on 14.05.2024.
//

import Foundation


protocol SignUpPresentation {
    func onSwitchLogin() -> Void

}



class SignUpPresenter {
    
    weak var view: SignUpView?
    var interactor: SignUpUseCase
    var router: SignUpRouting
    
    init(view: SignUpView?, interactor: SignUpUseCase, router: SignUpRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension SignUpPresenter: SignUpPresentation {
    
    func onSwitchLogin() {
        self.router.routeToLogin()
    }
}
