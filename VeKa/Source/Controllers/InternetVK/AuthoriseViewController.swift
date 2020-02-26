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
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
                
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authoriseInVk()
        
    }
}


extension AuthoriseViewController: WKNavigationDelegate {
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
            Session.shared.token = token
        }
        if let userId = params["user_id"] {
            Session.shared.userId = userId
        }
        
        
        print("token - \(Session.shared.token)")
        print("User ID - \(Session.shared.userId)")
        
        decisionHandler(.cancel)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if Session.shared.token.count > 0 {
            if let resultController = storyboard!.instantiateViewController(withIdentifier: "FriendListVkApi") as? FriendsVkApiViewController {
                present(resultController, animated: true, completion: nil)
            }
        }
        
        return false
    }
}

