//
//  VkPhotosRequests.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 23.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire

class VkPhotosRequests {
    
    static let vkPhotoRequests = VkPhotosRequests()
    private init () {}
    
    let userID = Session.shared.userId
    let token = Session.shared.token
    
    /**
    Send a request to the server to get the photos
    */
    func getPhotos() {
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userID]

        var urlPhotos = URLComponents()
        urlPhotos.scheme = "https"
        urlPhotos.host = "api.vk.com"
        urlPhotos.path = "/method/photos.getAll"
        urlPhotos.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        AF.request(urlPhotos.url!, method: .get, parameters: accessParameters).responseJSON { (response) in
            guard let json = response.value else { return }
            print(json)
            print(urlPhotos.url!)
        }
    }
}
