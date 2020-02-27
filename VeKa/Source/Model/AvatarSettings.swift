//
//  AvatarSettings.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 21.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

struct AvatarSettings {
    
    let tableViewHeight = 66
    var cornerRadius : CGFloat {
        get {
            return CGFloat(tableViewHeight / 2)
        }
    }
}

let avatarSettings = AvatarSettings()
