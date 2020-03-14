//
//  GetGroupVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class GetGroupsVkApi {
    
    var getGroupsVkApi : GroupsVkAPI?
    
    let userId = KeychainWrapper.standard.string(forKey: Session.Keys.hardUserId.rawValue) ?? ""
    let token = KeychainWrapper.standard.string(forKey: Session.Keys.hardToken.rawValue) ?? ""
    let url = "https://api.vk.com.method/"
    
    func getGroups(completionHandler: @escaping(Bool) -> ()) {
        
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userId]

        var urlGroups = URLComponents()
        urlGroups.scheme = "https"
        urlGroups.host = "api.vk.com"
        urlGroups.path = "/method/groups.get"
        urlGroups.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        guard let url = urlGroups.url else {return}
        
        AF.request(url, parameters: accessParameters).responseData { data in
            guard let data = data.value else {
                completionHandler(false)
                return }
           
            let groups = try! JSONDecoder().decode(GroupsVkAPI.self, from: data)
            self.getGroupsVkApi = groups
            let items = groups.response.items
            for i in 0..<items.count {
                
                let groups = GroupRealm()
                
                groups.name = items[i].name
                groups.id = items[i].id
                groups.photo = items[i].photo50
                
                do {
                    try Session.shared.realm.write {
                        Session.shared.realm.add(groups, update: .all)
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
