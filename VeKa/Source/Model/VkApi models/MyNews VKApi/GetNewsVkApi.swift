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
    
    func getNews(table: UITableView, completionHandler: @escaping(Bool) -> ()) {
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userId]

        var urlNews = URLComponents()
        urlNews.scheme = "https"
        urlNews.host = "api.vk.com"
        urlNews.path = "/method/newsfeed.get"
        urlNews.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        guard let url = urlNews.url else {return}
        
        AF.request(url, parameters: accessParameters).responseData { response in
            guard let data = response.data else {
                completionHandler(false)
                return }
           
            let news = try! JSONDecoder().decode(NewsVkAPI.self, from: data)
            
            self.getNewsVkApi = news
            
            let items = news.response.items
            let profiles = news.response.profiles
            let groups = news.response.groups
            
            
            
            for i in 0..<items.count {
                let newsRealm = NewsRealm()
                
                newsRealm.text = items[i].text
                newsRealm.id = i
                newsRealm.date = items[i].date
                if let attachments = items[i].attachments {
                    for photo in attachments {
                        if let size = photo.photo {
                            for o in size.sizes {
                                if o.type == .some(.r) {
                                    let photoRealm = PhotoRealm()
                                    photoRealm.height = Float(o.height)
                                    photoRealm.width = Float(o.width)
                                    photoRealm.url = o.url
                                    
                                    newsRealm.photos.append(photoRealm)
                                }
                            }
                        }
                    }
                }
                
                for profile in profiles {
                    if profile.id == items[i].sourceID {
                        newsRealm.avatar = profile.photo50
                        newsRealm.name = profile.firstName + " " + profile.lastName
                    }
                }
                for group in groups {
                    if -group.id == items[i].sourceID {
                        newsRealm.avatar = group.photo50
                        newsRealm.name = group.name
                    }
                }
                
                do {
                    try Session.shared.realm.write {
                        Session.shared.realm.add(newsRealm, update: .all)
                        table.reloadData()
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
