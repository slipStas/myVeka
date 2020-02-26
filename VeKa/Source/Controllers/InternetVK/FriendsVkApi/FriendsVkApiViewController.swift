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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsVkApiTableView.rowHeight = 50
        friendsVkApiTableView.dataSource = self
    }
}

extension FriendsVkApiViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsVkApiTableView.dequeueReusableCell(withIdentifier: "vkApiFriendsIdentifier", for: indexPath) as! FriendsVkApiTableViewCell
        
        cell.friendsVkApiNameLabel.text = "qqq"
    
        
        return cell
    }
}
