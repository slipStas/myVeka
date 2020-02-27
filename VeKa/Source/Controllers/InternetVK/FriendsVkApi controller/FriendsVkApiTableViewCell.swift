//
//  FriendsVkApiTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendsVkApiTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsVkApiNameLabel: UILabel!
    
    @IBOutlet weak var friendsVkApiAvatar: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        friendsVkApiAvatar.image = nil
        friendsVkApiNameLabel.text = nil
    }
}
