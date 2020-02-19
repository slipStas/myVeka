//
//  FriendInfoCollectionViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 14.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendInfoCollectionViewCell: UICollectionViewCell {
        
    @IBOutlet weak var friendInfoImageView: UIImageView!
    
    @IBOutlet weak var nameFriendInfoLabel: UILabel!
    
    @IBOutlet weak var likesView: LikesView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        friendInfoImageView.image = nil
        nameFriendInfoLabel.text = nil
    }
    
    override func awakeFromNib() {
        
        friendInfoImageView.isUserInteractionEnabled = true
        let tapOnIcon = UITapGestureRecognizer(target: self, action: #selector(tapOnIconView))
        tapOnIcon.numberOfTapsRequired = 1
        friendInfoImageView.addGestureRecognizer(tapOnIcon)
    }
    
    @objc func tapOnIconView(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.friendInfoImageView.transform = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4)
                        self.friendInfoImageView.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
                        self.friendInfoImageView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)

                        print("tap on image")
        })
    }
    
}
