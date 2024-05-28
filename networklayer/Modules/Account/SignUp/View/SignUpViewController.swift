//
//  SignUpViewController.swift
//  networklayer
//
//  Created by mert can çifter on 13.05.2024.
//

import UIKit

protocol SignUpView: class {
    
}

class SignUpViewController: UIViewController {

    
    var presenter: SignUpPresentation!
    
    
    let spinner = UIActivityIndicatorView(style: .large)

    
    private lazy var usernameTextField: UITextField = {
        let tf = CustomTextField()
        tf.setLeftView(image: UIImage.init(systemName: "person")!)
        return tf
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = CustomTextField()
        tf.setLeftView(image: UIImage.init(systemName: "envelope.fill")!)
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = CustomTextField()
        tf.isSecureTextEntry = true
        tf.setLeftView(image: UIImage.init(systemName: "lock")!)
        return tf
    }()
    
    
    private let registerButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRegister(sender: UIButton) {
        //sender.isEnabled = false
        
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text,!password.isEmpty else {
            sender.isEnabled = true
            return
        }
        
        
        //spinner.startAnimating()

    }
    
    @objc func handleLogin(sender: UIButton) {
        self.presenter.onSwitchLogin()
    }
    
    var textFields: [UITextField] {
        return [usernameTextField, emailTextField ,passwordTextField]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUICordinate()

        // Do any additional setup after loading the view.
    }
    

    

}


// MARK: -- UI Draw

extension SignUpViewController {
    
    func makeUICordinate() {
        
        view.backgroundColor = .systemBackground
        
        let stackTextField = UIStackView(arrangedSubviews: [usernameTextField,emailTextField,passwordTextField,registerButton])
        
        stackTextField.axis = .vertical
        stackTextField.spacing = 20

        view.addSubview(stackTextField)
        
        stackTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }

        
        textfieldDelegate()
        
        configureLoading()
    }
    
    func configureLoading() {
        let container = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        spinner.center = self.view.center
        container.addSubview(spinner)
        self.view.addSubview(container)
    }
    
    
}


extension SignUpViewController: UITextFieldDelegate {
    
    func textfieldDelegate(){
        textFields.forEach {
            $0.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}





extension SignUpViewController: SignUpView {
    
}


