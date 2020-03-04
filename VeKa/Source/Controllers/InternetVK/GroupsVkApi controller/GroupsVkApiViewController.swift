//
//  GroupsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import Kingfisher

class GroupsVkApiViewController: UIViewController {

    @IBOutlet weak var groupsVkApiTableView: UITableView!
    
    let getGroups = GetGroupsVkApi()
    let avatarSetings = AvatarSettings()
    let groups = Session.shared.realm.objects(GroupRealm.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsVkApiTableView.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        self.groupsVkApiTableView.dataSource = self
        
        getGroups.getGroups { (state) in
            if state {
                self.groupsVkApiTableView.reloadData()
            } else {
                print("Error with data from Realm")
            }
        }
    }
}

extension GroupsVkApiViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsVkApiTableView.dequeueReusableCell(withIdentifier: "vkApiGroupsIdentifier", for: indexPath) as! GroupsVkApiTableViewCell
        
        let urlImage = URL(string: groups[indexPath.row].photo)
        let cacheKey = String(groups[indexPath.row].id) + groups[indexPath.row].photo
        
        cell.groupVkApiNameLabel.text = groups[indexPath.row].name
        cell.groupVkApiAvatar.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))
        
        return cell
    }
}
