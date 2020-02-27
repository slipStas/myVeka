//
//  GroupsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class GroupsVkApiViewController: UIViewController {

    @IBOutlet weak var groupsVkApi: UITableView!
    
    let avatarSetings = AvatarSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VkGroupsRequests.vkGroupsRequest.getGroups()
        groupsVkApi.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        self.groupsVkApi.dataSource = self
    }

}

extension GroupsVkApiViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsVkApi.dequeueReusableCell(withIdentifier: "vkApiGroupsIdentifier", for: indexPath) as! GroupsVkApiTableViewCell
        
        cell.groupVkApiNameLabel.text = "qwerty"
        
        cell.groupVkApiAvatar.image = #imageLiteral(resourceName: "heart")
        
        return cell
    }
    
    
}
