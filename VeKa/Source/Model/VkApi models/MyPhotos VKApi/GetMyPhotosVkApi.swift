//
//  GetMyPhotosVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import Alamofire

class GetMyPhotosVkApi {
    
    var getPhotoVkApi : MyPhotosVkAPI?
    
    let token = Session.shared.token
    let userId = Session.shared.userId
    let url = "https://api.vk.com.method/"
    
    func getPhotos(completionHandler: @escaping(MyPhotosVkAPI, [UIImage]) -> ()) {
        
        var imageArray : [UIImage] = []

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
        
        AF.request(urlPhotos.url!, parameters: accessParameters).responseData { data in
           guard let data = data.value else { return }
           
           let photos = try! JSONDecoder().decode(MyPhotosVkAPI.self, from: data)
           self.getPhotoVkApi = photos
           
            for i in photos.response.items {
                for j in i.sizes {
                    if j.type == .m {
                        if let url = NSURL(string: j.url) {
                            let image = NSData(contentsOf: url as URL)
                            imageArray.append(UIImage(data: image! as Data)!)
                        }
                    }
                    
                }
           }
           completionHandler(self.getPhotoVkApi!, imageArray)
        }
    }
}
