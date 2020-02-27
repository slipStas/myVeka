//
//  GroupsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class GroupsVkApiViewController: UIViewController {

    @IBOutlet weak var groupsVkApiTableView: UITableView!
    
    let getGroups = GetGroupsVkApi()
    var groupsArray : [UIImage] = []
    let avatarSetings = AvatarSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsVkApiTableView.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        self.groupsVkApiTableView.dataSource = self
        
        getGroups.getGroups { (groups, imageArray) in
            self.groupsArray.append(contentsOf: imageArray)
            self.getGroups.getGroupsVkApi = groups
            
            self.groupsVkApiTableView.reloadData()
        }
    }
}

extension GroupsVkApiViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getGroups.getGroupsVkApi?.response.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsVkApiTableView.dequeueReusableCell(withIdentifier: "vkApiGroupsIdentifier", for: indexPath) as! GroupsVkApiTableViewCell
        
        cell.groupVkApiNameLabel.text = getGroups.getGroupsVkApi?.response.items[indexPath.row].name
        
        cell.groupVkApiAvatar.image = self.groupsArray[indexPath.row]
        
        return cell
    }
}
