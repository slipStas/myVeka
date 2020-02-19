//
//  Likes.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 28.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class Likes {
    
    enum LikesStatus {
        case like
        case noLike
    }
    
    var likesCounts : UInt
    var likeStatus : LikesStatus
    
    init(likesCounts: UInt, likeStatus: LikesStatus) {
        self.likesCounts = likesCounts
        self.likeStatus = likeStatus
    }
    
}
