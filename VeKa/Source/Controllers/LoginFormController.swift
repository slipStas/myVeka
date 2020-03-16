//
//  LoginFormController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 11.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginFormController: UIViewController {
    
    private lazy var alertView: RegistrationAlert = {
        let alertView : RegistrationAlert = (Bundle.main.loadNibNamed("RegistrationAlert", owner: self, options: nil)?.first as? RegistrationAlert)!
        alertView.delegate = self
        return alertView
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loadingView: LoadingView!
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var internetLoginButton: UIButton!
    
    @IBOutlet weak var registrationFireBaseButton: UIButton!
    
    @IBAction func registrationInFareBase(_ sender: Any) {
        setupBlurBackground()
        setupAlert()
        animateAlertIn()
    }
    
    @IBAction func authVkButton(_ sender: Any) {
        let token = KeychainWrapper.standard.string(forKey: Session.Keys.hardToken.rawValue) ?? ""
        if !token.isEmpty {
            let storyBoard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "VkApi") as! TabBarViewController
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let storyBoard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "authoriseInVK") as! AuthoriseViewController
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Enter your account:"
        loginLabel.text = "Login"
        passwordLabel.text = "Password"
        
        loginTextField.placeholder = "enter login"
        passwordTextField.placeholder = "enter password"
        
        loginButton.setTitle("Log In", for: .normal)
        registrationFireBaseButton.setTitle("Registration", for: .normal)
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
    
    func setupAlert() {
        view.addSubview(alertView)
        alertView.center = view.center
        alertView.fillAlertText()
        alertView.layer.cornerRadius = 10
        alertView.layer.masksToBounds = true
    }
    func setupBlurBackground() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    func animateAlertIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 0.7
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    func animateAlertOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.alertView.removeFromSuperview()
            self.visualEffectView.removeFromSuperview()
        }
    }
}

extension LoginFormController : AlertDelegate {
    func okButtonTapped() {
        print("ok")
        animateAlertOut()
    }
    
    func cancelButtonTapped() {
        animateAlertOut()
    }
}
