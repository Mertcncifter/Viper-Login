//
//  WindowPresenter.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import Foundation


protocol WindowPresentation {
    func initialize() -> Void
    func onLogin() -> Void
}


class WindowPresenter {
    
    private let router: WindowRouting
    private let interactor: WindowUseCase
    
    init(router: WindowRouting, interactor: WindowUseCase) {
        self.router = router
        self.interactor = interactor
        self.initialize()
    }
}


extension WindowPresenter: WindowPresentation {
    
    func initialize() {
        
        let existToken = UserDefaults.token == nil
        
        if(!existToken) {
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                
                guard let self = self else { return }
                
                self.interactor.getUser { data, error in
                    
                    if let error = error {
                        DispatchQueue.main.async {
                            self.router.routeTo(kind: .login)
                        }
                        return
                    }
                    
                    guard let data = data else {
                        DispatchQueue.main.async {
                            self.router.routeTo(kind: .login)
                        }
                        return
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.router.routeTo(kind: .home(data))
                    }
                }
            }
        }
        else {
            self.router.routeTo(kind: .login)
        }
    }
    
    func onLogin() {
        DispatchQueue.main.async {
            self.router.routeToLogin()
        }
    }
}
