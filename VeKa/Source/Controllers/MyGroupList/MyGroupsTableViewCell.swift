//
//  MyGroupsTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 14.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class MyGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var myGroupsImageView: UIImageView!
    @IBOutlet weak var myGroupsNameLabel: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        myGroupsImageView.image = nil
        myGroupsNameLabel.text = nil
    }
    
    override func awakeFromNib() {
        
        myGroupsImageView.isUserInteractionEnabled = true
        let tapOnIcon = UITapGestureRecognizer(target: self, action: #selector(tapOnIconView))
        tapOnIcon.numberOfTapsRequired = 1
        myGroupsImageView.addGestureRecognizer(tapOnIcon)
    }
    
    @objc func tapOnIconView(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.avatarView.transform = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4)
                        self.avatarView.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
                        self.avatarView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)

                        print("tap on image")
        })
    }
}
