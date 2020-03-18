//
//  AllGroupsViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 14.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    var allGroupsArray: [Group] = []
    var filteredGroups: [Group] = []
    let avatarSetings = AvatarSettings()

    @IBOutlet weak var allGroupsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allGroupsTableView.rowHeight = CGFloat(self.avatarSetings.tableViewHeight)
        allGroupsTableView.dataSource = self
        
        setUpSearchBar()
        setUpGroups()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //animateHeightTable(tableView: allGroupsTableView)
    }
    
    private func setUpGroups() {
        allGroupsArray.append(Group(name: "AppStores", icon: "icon_1"))
        allGroupsArray.append(Group(name: "Safaries", icon: "icon_2"))
        allGroupsArray.append(Group(name: "Mails", icon: "icon_3"))
        allGroupsArray.append(Group(name: "ApleTVs", icon: "icon_4"))
        allGroupsArray.append(Group(name: "Homes", icon: "icon_5"))
        allGroupsArray.append(Group(name: "Siries", icon: "icon_6"))
        allGroupsArray.append(Group(name: "Locators", icon: "icon_7"))
        allGroupsArray.append(Group(name: "Photo Boothes", icon: "icon_8"))
        allGroupsArray.append(Group(name: "Shares", icon: "icon_9"))
        allGroupsArray.append(Group(name: "Maps", icon: "icon_10"))
        
        filteredGroups = allGroupsArray
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self

    }
}

extension AllGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredGroups = allGroupsArray
            allGroupsTableView.reloadData()
            return
        }
        filteredGroups = allGroupsArray.filter({$0.name.lowercased().contains(searchText.lowercased())})
        
        allGroupsTableView.reloadData()
    }
    
}

extension AllGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allGroupsTableView.dequeueReusableCell(withIdentifier: "allGroupsIdentifier", for: indexPath) as! AllGroupsTableViewCell
        
        cell.allGroupImageView.image = UIImage(named: filteredGroups[indexPath.row].icon)
        cell.allGroupLabel.text = filteredGroups[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select all group")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
