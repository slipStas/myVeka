//
//  RegistrationAlert.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 16.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

protocol AlertDelegate {
    func okButtonTapped()
    func cancelButtonTapped()
}

class RegistrationAlert: UIView {

    var delegate : AlertDelegate? = nil
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func okButtonTapped(_ sender: Any) {
        delegate?.okButtonTapped()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.cancelButtonTapped()
    }
    
    func fillAlertText() {
        self.backgroundView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.emailTextField.textContentType = .emailAddress
        self.emailTextField.placeholder = "enter your email"
        
        self.passwordTextField.textContentType = .password
        self.passwordTextField.placeholder = "enter password"
        self.passwordTextField.isSecureTextEntry = true
        
        self.repeatPasswordTextfield.textContentType = .password
        self.repeatPasswordTextfield.placeholder = "repeat password"
        self.repeatPasswordTextfield.isSecureTextEntry = true
        
        self.okButton.setTitle("Ok", for: .normal)
        
        self.cancelButton.setTitle("Cancel", for: .normal)
        
    }
    
}
