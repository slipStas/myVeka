//
//  FriendsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendsVkApiViewController: UIViewController {

    @IBOutlet weak var friendsVkApiTableView: UITableView!
    
    let getFriends = GetVkApi()
    var friendsAvatars : [UIImage] = []
    let avatarSetings = AvatarSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsVkApiTableView.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        friendsVkApiTableView.dataSource = self
        
        getFriends.getFriends { (friends, imageArray) in
            self.friendsAvatars.append(contentsOf: imageArray)
            self.getFriends.serverFriendList = friends
            
            self.friendsVkApiTableView.reloadData()
        }
    }
}

extension FriendsVkApiViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getFriends.serverFriendList?.response.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsVkApiTableView.dequeueReusableCell(withIdentifier: "vkApiFriendsIdentifier", for: indexPath) as! FriendsVkApiTableViewCell
        
        cell.friendsVkApiNameLabel.text = (getFriends.serverFriendList?.response.items[indexPath.row].firstName ?? "") + " " + (getFriends.serverFriendList?.response.items[indexPath.row].lastName ?? "")
        
        cell.friendsVkApiAvatar.image = self.friendsAvatars[indexPath.row]
    
        
        return cell
    }
}
