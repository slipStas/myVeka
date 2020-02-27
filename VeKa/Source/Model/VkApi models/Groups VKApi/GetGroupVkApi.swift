//
//  GetGroupVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire

class GetGroupsVkApi {
    
    var getGroupsVkApi : GroupsVkAPI?
    
    let token = Session.shared.token
    let userId = Session.shared.userId
    let url = "https://api.vk.com.method/"
    
    func getGroups(completionHandler: @escaping(GroupsVkAPI, [UIImage]) -> ()) {
        
        var imageArray : [UIImage] = []
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userId]

        var urlGroups = URLComponents()
        urlGroups.scheme = "https"
        urlGroups.host = "api.vk.com"
        urlGroups.path = "/method/groups.get"
        urlGroups.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        AF.request(urlGroups.url!, parameters: accessParameters).responseData { data in
           guard let data = data.value else { return }
           
           let groups = try! JSONDecoder().decode(GroupsVkAPI.self, from: data)
           self.getGroupsVkApi = groups
           
            for i in groups.response.items {
                if let url = NSURL(string: i.photo50) {
                   let image = NSData(contentsOf: url as URL)
                   imageArray.append(UIImage(data: image! as Data)!)
               }
           }
           completionHandler(self.getGroupsVkApi!, imageArray)
        }
    }
}
