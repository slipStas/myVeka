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
    
    func getNewss(completionHandler: @escaping(Bool) -> ()) {
        
        
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
                
                let news = NewsRealm()
                
                news.avatar = profiles[i].photo100
                news.name = profiles[i].firstName + " " + profiles[i].lastName
                news.text = items[i].text
                news.id = i
//                groups.name = items[i].name
//                groups.id = items[i].id
//                groups.photo = items[i].photo50
                
                do {
                    try Session.shared.realm.write {
                        Session.shared.realm.add(news, update: .all)
                    }
                } catch {
                    completionHandler(false)
                    print("error")
                }
            }
           completionHandler(true)
        }
    }
}
