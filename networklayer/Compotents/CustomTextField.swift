//
//  CustomTextField.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import UIKit


class CustomTextField: UITextField {
    
    var insets: UIEdgeInsets

    
    init() {
        self.insets = UIEdgeInsets(top: 8, left: 40, bottom: 8, right: 8)
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
}
