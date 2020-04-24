//
//  AuthoriseViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 23.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftKeychainWrapper


class AuthoriseViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    func authoriseInVk() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7332528"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
                
        let request = URLRequest(url: urlComponents.url!)
        
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInteractive).async {
            if CheckInternet.Connection() {
                print("internet connection is OK")
                self.authoriseInVk()
            } else {
                print("internet connection is  NOT OK")
                DispatchQueue.main.async {
                    let storyBoard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "VkApi") as! TabBarViewController
                    self.present(newViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

extension AuthoriseViewController: WKNavigationDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            DispatchQueue.main.async {
                print(Float(self.webView.estimatedProgress))
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
                
        if let token = params["access_token"] {
            KeychainWrapper.standard.set(token, forKey: Session.Keys.hardToken.rawValue)
            Session.shared.hardToken = KeychainWrapper.standard.string(forKey: Session.Keys.hardToken.rawValue)!
        }
        
        if let userId = params["user_id"] {
            KeychainWrapper.standard.set(userId, forKey: Session.Keys.hardUserId.rawValue)
            Session.shared.hardUserId = KeychainWrapper.standard.string(forKey: Session.Keys.hardUserId.rawValue)!
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "VkApi") as! TabBarViewController
        self.present(newViewController, animated: true, completion: nil)
        print("token is not empty = \(Session.shared.hardToken)")
        
        decisionHandler(.cancel)
    }
}

