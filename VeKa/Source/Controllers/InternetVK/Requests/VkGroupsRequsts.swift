//
//  VkGroupsRequsts.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 23.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire

class VkGroupsRequsts {
    
    static let vkGroupsRequest = VkGroupsRequsts()
    private init () {}
    
    let userID = Session.shared.userId
    let token = Session.shared.token
    
    /**
    Send a request to the server to get the groups
    */
    func getGroups() {
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userID]

        var urlGroups = URLComponents()
        urlGroups.scheme = "https"
        urlGroups.host = "api.vk.com"
        urlGroups.path = "/method/groups.get"
        urlGroups.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        AF.request(urlGroups.url!, method: .get, parameters: accessParameters).responseJSON { (response) in
            print(response)
        }
    }
    
    func groupSearch(search: String, printCounts: Int) {
        
        let accessParameters: Parameters = ["access_token" : token]
        var urlGroups = URLComponents()
        urlGroups.scheme = "https"
        urlGroups.host = "api.vk.com"
        urlGroups.path = "/method/groups.search"
        urlGroups.queryItems = [
            URLQueryItem(name: "q", value: search),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "count", value: String(printCounts)),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        AF.request(urlGroups.url!, method: .get, parameters: accessParameters).responseJSON { (response) in
            print(response)
        }
    }
}
