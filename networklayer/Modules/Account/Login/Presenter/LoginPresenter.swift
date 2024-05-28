//
//  LoginPresenter.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import Foundation



protocol LoginPresentation {
    func login(username: String, password: String) -> Void
    func onSwitchSignUp() -> Void
    func validate(usingField fields: [FieldValidatable], completion: (Bool) -> ())
}



class LoginPresenter {
    
    weak var view: LoginView?
    var interactor: LoginUseCase
    var router: LoginRouting
    
    init(view: LoginView?, interactor: LoginUseCase, router: LoginRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension LoginPresenter: LoginPresentation {
 

    func login(username: String, password: String) {
        
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let self = self else { return }

            self.interactor.login(username: username, password: password) { data, error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        self.view?.showError(error)
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.view?.showError("Geçersiz giriş yanıtı")
                    }
                    return
                }
                
                UserDefaults.token = data.accessToken
                UserDefaults.refreshToken = data.refreshToken
                
                self.interactor.fetchUser { data, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.view?.showError(error)
                        }
                        return
                    }
                    
                    guard let data = data else {
                        DispatchQueue.main.async {
                            self.view?.showError("Geçersiz giriş yanıtı")
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.router.routeToWindow(user: data)
                    }
                }
            }
        }
    }
    
    func onSwitchSignUp() {
        self.router.routerToSignUp()
    }
    
    func validate(usingField fields: [FieldValidatable], completion: (Bool) -> ()) {
        
        var isValid = true
        
        fields.forEach { (field) in
            field.validationRules.forEach { (rule) in
                if !rule.validate(value: field.validationText) {
                    isValid = false
                    return
                }
            }
        }
        
        self.view?.updateInvalidFields()
        
        if isValid {
            
        }
        
        completion(isValid)
    }
    

}
