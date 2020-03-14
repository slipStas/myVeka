//
//  GroupsVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class GroupsVkApiViewController: UIViewController {

    @IBOutlet weak var groupsVkApiTableView: UITableView!
    
    let getGroups = GetGroupsVkApi()
    let avatarSetings = AvatarSettings()
    let groups = Session.shared.realm.objects(GroupRealm.self)
    var token : NotificationToken?
    
    func pairTableAndRealm() {
        
    token = self.groups.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.groupsVkApiTableView else { return }
            switch changes {
            case .initial(let changedData):
                if self?.groups.count != changedData.count {
                    tableView.reloadData()
                }
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                if insertions.count > 0 {
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .right)
                }
                if deletions.count > 0 {
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .left)
                }
                if modifications.count > 0 {
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .right)
                }
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsVkApiTableView.rowHeight = CGFloat(avatarSetings.tableViewHeight)
        self.groupsVkApiTableView.dataSource = self
        
        if groups.count == 0 {
            getGroups.getGroups { (state) in
                if state {
                    print("Groups was added")
                } else {
                    print("Error with data from Realm")
                }
            }
        }
        pairTableAndRealm()
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
