//
//  FriendsListTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 13.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {

    @IBOutlet weak var friendNameLabel: UILabel!
    
    @IBOutlet weak var friendsPhotoImageView: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        friendsPhotoImageView.image = nil
        friendNameLabel.text = nil
    }
    
}
