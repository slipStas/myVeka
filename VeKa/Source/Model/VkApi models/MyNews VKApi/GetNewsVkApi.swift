//
//  GetNewsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 03.04.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class GetNewsVkApi {
    
    var getNewsVkApi : NewsVkAPI?
    
    let userId = KeychainWrapper.standard.string(forKey: Session.Keys.hardUserId.rawValue) ?? ""
    let token = KeychainWrapper.standard.string(forKey: Session.Keys.hardToken.rawValue) ?? ""
    let url = "https://api.vk.com.method/"
    
    func getNews(completionHandler: @escaping(Bool) -> ()) {
        
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userId]

        var urlNews = URLComponents()
        urlNews.scheme = "https"
        urlNews.host = "api.vk.com"
        urlNews.path = "/method/newsfeed.get"
        urlNews.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        guard let url = urlNews.url else {return}
        
        AF.request(url, parameters: accessParameters).responseData { data in
            guard let data = data.value else {
                completionHandler(false)
                return }
           
            let news = try! JSONDecoder().decode(NewsVkAPI.self, from: data)
            self.getNewsVkApi = news
            let items = news.response.items
            let profiles = news.response.profiles
            
            
            
            for i in 0..<items.count {
                
                let newsRealm = NewsRealm()
                
//                news.avatar = profiles[i].photo100
//                news.name = profiles[i].firstName + " " + profiles[i].lastName
                
                print("items count - \(items.count)")
                print("i - \(i)")
                newsRealm.text = items[i].text
                newsRealm.id = i
                
                do {
                    try Session.shared.realm.write {
                        Session.shared.realm.add(newsRealm, update: .all)
                    }
                } catch {
                    completionHandler(false)
                    print("error")
                }
            }
//            for i in 0..<profiles.count {
//                
//                newsRealm.avatar = profiles[i].photo100
//                newsRealm.name = profiles[i].firstName + " " + profiles[i].lastName
//                
//                do {
//                    try Session.shared.realm.write {
//                        Session.shared.realm.add(newsRealm, update: .all)
//                    }
//                } catch {
//                    completionHandler(false)
//                    print("error")
//                }
//            }
           completionHandler(true)
        }
    }
}
