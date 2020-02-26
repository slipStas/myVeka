//
//  VkFriendsRequest.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 23.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire

class VkFriendsRequest {
    
    static let friendsRequest = VkFriendsRequest()
    private init () {}
    
    let userID = Session.shared.userId
    let token = Session.shared.token
    
    /**
    Send a request to the server to get the friends list
    */
    func showFriends() {
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userID]

        var urlFriends = URLComponents()
        urlFriends.scheme = "https"
        urlFriends.host = "api.vk.com"
        urlFriends.path = "/method/friends.get"
        urlFriends.queryItems = [
            URLQueryItem(name: "fields", value: "nickname"),
            URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "fields", value: "country"),
            URLQueryItem(name: "fields", value: "photo_200_orig"),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        AF.request(urlFriends.url!, method: .get, parameters: accessParameters).responseJSON { (response) in
            guard let json = response.value else { return }
            print(json)
        }
    }
}

