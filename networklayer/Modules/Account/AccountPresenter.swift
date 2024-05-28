//
//  AccountPresenter.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import Foundation


protocol AccountPresentation {
    func viewDidLoad() -> Void
}


class AccountPresenter {
    
    weak var view: AccountView?
    private let router: AccountRouting?
    
    init(router: AccountRouting?) {
        self.router = router
    }
    
}


extension AccountPresenter: AccountPresentation {
    
    func viewDidLoad() {
        self.router?.showLogin()
    }
    
}
