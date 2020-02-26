//
//  LoginFormController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 11.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loadingView: LoadingView!
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var internetLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Enter your account:"
        loginLabel.text = "Login"
        passwordLabel.text = "Password"
        
        loginTextField.placeholder = "enter login"
        passwordTextField.placeholder = "enter password"
        
        loginButton.setTitle("Log In", for: .normal)
        internetLoginButton.setTitle("Authorise in VK", for: .normal)
        
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }

    @objc func keyboardWasShow(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

    @objc func hideKeyboard() {
            self.scrollView?.endEditing(true)
        }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "fromLoginController" {
            return checkUsersData()
        }
        if identifier == "authorise" {
            if let resultController = storyboard!.instantiateViewController(withIdentifier: "authoriseInVK") as? AuthoriseViewController {
                present(resultController, animated: true, completion: nil)
            }
        }
        return false
    }
    
    func checkUsersData() -> Bool {
        // Получаем текст логина
        let login = loginTextField.text!
        // Получаем текст-пароль
        let password = passwordTextField.text!
        
        // Проверяем, верны ли они
        if login == Session.shared.login && password == Session.shared.password {
            print("успешная авторизация")
            return true
        } else {
            print("неуспешная авторизация")
            showIdentificationError()
            return false
        }
    }
    
    func showIdentificationError() {
        let alert = UIAlertController(title: "Error", message: "Invalid login or password", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
