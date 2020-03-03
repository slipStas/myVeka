//
//  FriendsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsVkApiViewController: UIViewController {

    @IBOutlet weak var friendsVkApiTableView: UITableView!
    
    let getFriends = GetVkApi()
    let friendRealm = FriendRealm()
    var friendsRealm : [FriendRealm] = []
    let realm = try! Realm()
    
    var friendsAvatars : [UIImage] = []
    let avatarSetings = AvatarSettings()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsVkApiTableView.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        
        
        let friendsRealm = realm.objects(FriendRealm.self)
        
        for i in friendsRealm {
            self.friendsRealm.append(i)
        }
        
        if friendsRealm.count < 1 {

            getFriends.getFriends { (friends, imageArray) in
                self.friendsAvatars.append(contentsOf: imageArray)
                self.getFriends.serverFriendList = friends

                for i in friends.response.items {
                    self.friendRealm.firstName = i.firstName
                    self.friendRealm.lastName = i.lastName
                    self.friendRealm.id = i.id
                    do {
                        self.realm.beginWrite()
                        self.realm.add(self.friendRealm)
                        try self.realm.commitWrite()
                    } catch {
                            print(error)
                        }
                }

                self.friendsVkApiTableView.reloadData()
            }
        }
        
        friendsVkApiTableView.dataSource = self
    }
}

extension FriendsVkApiViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendsRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsVkApiTableView.dequeueReusableCell(withIdentifier: "vkApiFriendsIdentifier", for: indexPath) as! FriendsVkApiTableViewCell
        
        cell.friendsVkApiNameLabel.text = friendsRealm[indexPath.row].firstName + " " + friendsRealm[indexPath.row].lastName
        
        //cell.friendsVkApiNameLabel.text = (friendsRealm [indexPath.row].firstName ?? "") + " " + (getFriends.serverFriendList?.response.items[indexPath.row].lastName ?? "")
        cell.friendsVkApiAvatar.image = #imageLiteral(resourceName: "image_4")
        //cell.friendsVkApiAvatar.image = self.friendsAvatars[indexPath.row]
    
        
        return cell
    }
}
