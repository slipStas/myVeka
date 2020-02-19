//
//  AvatarView.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 21.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(avatarSettings.cornerRadius)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
    }
}
