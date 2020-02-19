//
//  FriendInfoViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 14.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendInfoViewController: UIViewController {
    
    var friendInfoList : [User] = []
    
    @IBOutlet weak var friendInfoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendInfoCollectionView.dataSource = self
        friendInfoCollectionView.delegate = self

    }
}

extension FriendInfoViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = friendInfoCollectionView.dequeueReusableCell(withReuseIdentifier: "friendInfoIdentifire", for: indexPath) as! FriendInfoCollectionViewCell
        
        cell.friendInfoImageView.image = friendInfoList[indexPath.row].avatar
        cell.nameFriendInfoLabel.text = friendInfoList[indexPath.row].name
        cell.likesView.likesCount.text = String(self.friendInfoList[indexPath.row].likes.likesCounts)
       
        
        switch self.friendInfoList[indexPath.row].likes.likeStatus {
        case .like:
            cell.likesView.likesStatus = .like
        case .noLike:
            cell.likesView.likesStatus = .noLike
        }
        
        cell.likesView.onTap = {
            if cell.likesView.likesStatus == .noLike {
                self.friendInfoList[indexPath.row].likes.likesCounts += 1
                self.friendInfoList[indexPath.row].likes.likeStatus = .like
                cell.likesView.likesStatus = .like
                cell.likesView.likesCount.text = String(self.friendInfoList[indexPath.row].likes.likesCounts)
            } else {
                self.friendInfoList[indexPath.row].likes.likesCounts -= 1
                self.friendInfoList[indexPath.row].likes.likeStatus = .noLike
                cell.likesView.likesStatus = .noLike
                cell.likesView.likesCount.text = String(self.friendInfoList[indexPath.row].likes.likesCounts)
            }
        }
        
        print(cell.likesView.likesStatus)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "photoFriendsIdentifier" {
            if let destinationVC = segue.destination  as? FriendsPhotosViewController {
                let friendPhotos: [UIImage] = self.friendInfoList[0].photos
                destinationVC.photoArray = friendPhotos
            }
        }
    }
}





