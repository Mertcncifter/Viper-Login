//
//  ProfileViewController.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let user: User
    let onLogout: () -> Void
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.image = UIImage(named: "profile")
        return view
    }()
    
    private lazy var fullNameTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var fullNameStackView: UIStackView = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Full Name"
        let stackView = UIStackView(arrangedSubviews: [label,fullNameTitle])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var usernameTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    private lazy var usernameStackView: UIStackView = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Username"

        let stackView = UIStackView(arrangedSubviews: [label,usernameTitle])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var emailTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var emailStackView: UIStackView = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Email"

        let stackView = UIStackView(arrangedSubviews: [label,emailTitle])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var phoneNumberTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var phoneNumberStackView: UIStackView = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "Phone Number"

        let stackView = UIStackView(arrangedSubviews: [label,phoneNumberTitle])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let logoutButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLogout(sender: UIButton) {
        self.onLogout()
    }
    
    
    init(user: User,onLogout: @escaping() -> Void) {
        self.user = user
        self.onLogout = onLogout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view)
            make.height.width.equalTo(150)
        }
        
        
        view.addSubview(fullNameStackView)
        
        fullNameStackView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(5)
        }
        
        view.addSubview(usernameStackView)
        
        usernameStackView.snp.makeConstraints { make in
            make.top.equalTo(fullNameStackView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(5)
        }
        
        view.addSubview(emailStackView)
        
        emailStackView.snp.makeConstraints { make in
            make.top.equalTo(usernameStackView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(5)
        }
        
        view.addSubview(phoneNumberStackView)
        
        phoneNumberStackView.snp.makeConstraints { make in
            make.top.equalTo(emailStackView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(5)
        }
        
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            
        }
        
        
        usernameTitle.text = user.userName
        fullNameTitle.text = user.fullName
        emailTitle.text = user.email
        phoneNumberTitle.text = user.phoneNumber
        
    }
    

    

}
