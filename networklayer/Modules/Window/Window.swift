//
//  Window.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit


class Window: UIWindow {
    
    var presenter: WindowPresentation!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTokenRefreshFailure), name: .didFailToRefreshToken, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .didFailToRefreshToken, object: nil)
    }
    
    @objc private func handleTokenRefreshFailure() {
        self.presenter.onLogin()
    }
}
