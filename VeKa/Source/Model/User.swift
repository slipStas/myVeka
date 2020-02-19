//
//  User.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 17.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class User {
    
    var name = ""
    var avatar = UIImage()
    var likes = Likes(likesCounts: 0, likeStatus: .noLike)
    var photos: [UIImage] = []
    
    init(name: String, avatar: UIImage, likes: Likes, photos: [UIImage]) {
        self.name = name
        self.avatar = avatar
        self.likes = likes
        self.photos = photos
    }
    
}



