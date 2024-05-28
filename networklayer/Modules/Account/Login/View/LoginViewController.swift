//
//  LoginViewController.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import UIKit
import SnapKit

protocol LoginView: AnyObject {
    func updateInvalidFields() -> Void
    func showError(_ message: String)

}

class LoginViewController: UIViewController {
    
    var presenter: LoginPresentation!

    let spinner = UIActivityIndicatorView(style: .large)
    
    private lazy var usernameTextField: AccountTextControl = {
        let tf = AccountTextControl()
        tf.configure(title: "Username", validationRules: [RequiredRule()], contentType: .emailAddress)
        tf.inputTextField.setLeftView(image: UIImage.init(systemName: "person")!)
        return tf
    }()
    
    private lazy var passwordTextField: AccountTextControl = {
        let tf = AccountTextControl()
        tf.configure(title: "Password", validationRules: [RequiredRule()], contentType: .password)
        tf.inputTextField.setLeftView(image: UIImage.init(systemName: "lock")!)
        return tf
    }()
    
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLogin(sender: UIButton) {
        
        self.presenter.validate(usingField: [usernameTextField,passwordTextField]) { (isValid) in
            if isValid {
                self.presenter.login(username: usernameTextField.validationText, password: passwordTextField.validationText)
            }
            
            
        }
        
        /*
        //sender.isEnabled = false
        
        guard let username = usernameTextField.inputTextField.text, !username.isEmpty,
              let password = passwordTextField.text,!password.isEmpty else {
            sender.isEnabled = true
            return
        }
        
        presenter.login(username: username, password: password)
        
        //spinner.startAnimating()
         */

    }
    
    @objc func handleSignUp(sender: UIButton) {
        self.presenter.onSwitchSignUp()
    }
    
    var textFields: [UITextField] {
        return [usernameTextField.inputTextField, passwordTextField.inputTextField]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeUICordinate()
        
    }
}


// MARK: -- UI Draw

extension LoginViewController {
    
    func makeUICordinate() {
        
        view.backgroundColor = .systemBackground
        
        let stackTextField = UIStackView(arrangedSubviews: [usernameTextField,passwordTextField,loginButton])
        
        stackTextField.distribution = .fillEqually
        stackTextField.axis = .vertical
        stackTextField.spacing = 40

        view.addSubview(stackTextField)
        
        stackTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
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


extension LoginViewController: LoginView {
    
    func updateInvalidFields() {
        usernameTextField.setErrorMessage()
        passwordTextField.setErrorMessage()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
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
 
}


