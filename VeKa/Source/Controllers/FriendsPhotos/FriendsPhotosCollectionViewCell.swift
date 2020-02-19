//
//  FriendsPhotosCollectionViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 05.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendsPhotosCollectionViewCell: UICollectionViewCell {
    
    var friendsPhotoViewController : FriendsPhotosViewController?

    @IBOutlet weak var friendsPhotos: UIImageView!
    
    override func prepareForReuse() {
        self.friendsPhotos.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendsPhotos.isUserInteractionEnabled = true
        
        friendsPhotos.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
    }
    
    @objc func animate() {
        
        friendsPhotoViewController?.animateImageView(imageView: friendsPhotos)
        
    }
}
