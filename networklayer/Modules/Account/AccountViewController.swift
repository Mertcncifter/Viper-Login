//
//  AccountViewController.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


protocol AccountView: class {
    
}

class AccountViewController: UIViewController {

    var presenter: AccountPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.viewDidLoad()
    }
    


}


extension AccountViewController: AccountView {
    
}
