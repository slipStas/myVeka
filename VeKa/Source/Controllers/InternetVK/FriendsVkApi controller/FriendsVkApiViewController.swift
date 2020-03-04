//
//  FriendsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class FriendsVkApiViewController: UIViewController {

    @IBOutlet weak var friendsVkApiTableView: UITableView!
    
    let friends = Session.shared.realm.objects(FriendRealm.self)
    let getFriends = GetVkApi()
    let avatarSetings = AvatarSettings()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsVkApiTableView.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        
        
        getFriends.getFriends { (state) in
            if state {
                self.friendsVkApiTableView.reloadData()
            } else {
                print("error")
            }
        }
        
        friendsVkApiTableView.dataSource = self
    }
}

extension FriendsVkApiViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsVkApiTableView.dequeueReusableCell(withIdentifier: "vkApiFriendsIdentifier", for: indexPath) as! FriendsVkApiTableViewCell
        
        let urlImage = URL(string: friends[indexPath.row].photo)
        let cacheKey = String(friends[indexPath.row].id) + friends[indexPath.row].photo
        
        cell.friendsVkApiNameLabel.text = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
        cell.friendsVkApiAvatar.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))
        
        return cell
    }
}
