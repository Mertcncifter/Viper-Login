//
//  AccountTextControl.swift
//  networklayer
//
//  Created by mert can çifter on 15.05.2024.
//

import UIKit
import SnapKit

class AccountTextControl: UIControl {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    lazy var inputTextField: CustomTextField = {
        let textField = CustomTextField()
        return textField
    }()
    
    
    var rules: [Rule] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    
    private func commonInit() {
        
        backgroundColor = .clear
         
        addSubview(titleLabel)
        addSubview(errorLabel)
        addSubview(inputTextField)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(inputTextField.snp.bottom).offset(5)
        }
        
    }
    
    func configure(title: String, validationRules: [Rule], contentType: UITextContentType) {
        self.titleLabel.text = title
        self.inputTextField.textContentType = contentType
        self.inputTextField.isSecureTextEntry = (contentType == .password)
        self.setRules(rules: validationRules)
        self.inputTextField.delegate = self
    }
}


extension AccountTextControl: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}

extension AccountTextControl: FieldValidatable {
    
    var validationRules: [Rule] {
        get {
            return rules
        }
        
        set {
            rules = newValue
        }
    }
    
    var validationText: String {
        return self.inputTextField.text ?? ""
    }
    
    func setRules(rules: [Rule]) {
        validationRules.removeAll()
        validationRules.append(contentsOf: rules)
    }
    
    func setErrorMessage() -> Void {
        errorLabel.text = self.rules
            .filter({ !$0.validate(value: self.validationText)})
            .first
            .map({$0.errorMessage()})
    }
    
    
}
