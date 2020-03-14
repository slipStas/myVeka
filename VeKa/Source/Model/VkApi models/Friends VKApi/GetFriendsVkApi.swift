//
//  GetFriendsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class GetVkApi {
    
    var serverFriendList: UserVkAPI?

    let userId = KeychainWrapper.standard.string(forKey: Session.Keys.hardUserId.rawValue) ?? ""
    let token = KeychainWrapper.standard.string(forKey: Session.Keys.hardToken.rawValue) ?? ""
    let url = "https://api.vk.com.method/"
    
    func getFriends(completionHandler: @escaping(Bool) -> ()) {
        print("----------------")
        print(token)
        print(userId)
        print("----------------")

        var urlFriends = URLComponents()
        urlFriends.scheme = "https"
        urlFriends.host = "api.vk.com"
        urlFriends.path = "/method/friends.get"
        urlFriends.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userId),

            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "fields", value: "country"),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        guard let url = urlFriends.url else {return}
        
        AF.request(url).responseData { data in
            guard let data = data.value else {
                completionHandler(false)
                return }
                        
            let friends = try! JSONDecoder().decode(UserVkAPI.self, from: data)
            self.serverFriendList = friends
            let items = friends.response.items
            for i in 0..<items.count {
                
                let friend = FriendRealm()
                
                friend.firstName = items[i].firstName
                friend.lastName = items[i].lastName
                friend.id = items[i].id
                friend.photo = items[i].photo50
                
                do {
                    try Session.shared.realm.write {
                        Session.shared.realm.add(friend, update: .all)
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
