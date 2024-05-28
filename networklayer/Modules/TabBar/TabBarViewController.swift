//
//  TabBarViewController.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit
import SnapKit
 
typealias Tabs = (
    product: UIViewController,
    profile: UIViewController
)


class TabBarViewController: UITabBarController {

    // MARK: -- Properties
    

    // MARK: -- Lifecycle

    init(tabs: Tabs) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers([tabs.product,tabs.profile], animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
    }
    
}

// MARK: -- UI Draw

extension TabBarViewController {
    
    private func configureUI() {
        configureTabBarAppereance()
    }
    
    private func configureTabBarAppereance() {
        let appearance = UITabBarAppearance()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemGroupedBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
            tabBar.tintColor = .label
        }
        else{
            tabBar.standardAppearance = appearance
            tabBar.tintColor = .label
        }
    }
}



