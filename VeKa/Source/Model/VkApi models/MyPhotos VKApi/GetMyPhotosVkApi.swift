//
//  GetMyPhotosVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class GetMyPhotosVkApi {
    
    var getPhotoVkApi : MyPhotosVkAPI?
    
    let userId = KeychainWrapper.standard.string(forKey: Session.Keys.hardUserId.rawValue) ?? ""
    let token = KeychainWrapper.standard.string(forKey: Session.Keys.hardToken.rawValue) ?? ""
    let url = "https://api.vk.com.method/"
    
    func getPhotos(completionHandler: @escaping(Bool) -> ()) {
        
        let accessParameters: Parameters = ["access_token" : token, "user_id" : userId]

        var urlPhotos = URLComponents()
        urlPhotos.scheme = "https"
        urlPhotos.host = "api.vk.com"
        urlPhotos.path = "/method/photos.getAll"
        urlPhotos.queryItems = [
            URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "0"),
            URLQueryItem(name: "count", value: "200"),
            URLQueryItem(name: "v", value: "5.102")
        ]
        
        guard let urlPhoto = urlPhotos.url else {return}

        AF.request(urlPhoto, parameters: accessParameters).responseData { response in
            guard let data = response.data else {
                completionHandler(false)
                return}
           
            let photos = try! JSONDecoder().decode(MyPhotosVkAPI.self, from: data)
            self.getPhotoVkApi = photos
            let items = photos.response.items

            for i in 0..<items.count {
                
                let photos = MyPhotosRealm()
                
                photos.id = items[i].id
                
                for j in 0..<items[i].sizes.count {
                    photos.photo = items[i].sizes[j].url
                }
                
                do {
                    try Session.shared.realm.write {
                        Session.shared.realm.add(photos, update: .all)
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
