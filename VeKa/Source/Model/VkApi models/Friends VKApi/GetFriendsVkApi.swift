//
//  GetFriendsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire

class GetVkApi {
    
    var serverFriendList: UserVkAPI?

    let token = Session.shared.token
    let userId = Session.shared.userId
    let url = "https://api.vk.com.method/"
    
    func getFriends(completionHandler: @escaping(UserVkAPI, [UIImage]) -> ()) {
               
        var imageArray : [UIImage] = []
        
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
        
        AF.request(urlFriends.url!).responseData { data in
            guard let data = data.value else { return }
            
            let friends = try! JSONDecoder().decode(UserVkAPI.self, from: data)
            self.serverFriendList = friends
            
            for i in friends.response.items {
                if let url = NSURL(string: i.photo50) {
                    let image = NSData(contentsOf: url as URL)
                    imageArray.append(UIImage(data: image! as Data)!)
                }
            }
            completionHandler(self.serverFriendList!, imageArray)
        }
    }
}
