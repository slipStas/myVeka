//
//  MyGroupsViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 14.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyGroupsViewController: UIViewController {
    
    var myGroupsArray: [Group] = []
    let avatarSetings = AvatarSettings()
    var ref : DatabaseReference!

    @IBOutlet weak var myGroupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "groups")
        ref.observe(.value) { (data) in
            for i in data.children {
                if let value = i as? DataSnapshot {
                    let json = value.value as! [String:Any]
                    let group = Group(name: json["name"] as! String, icon: json["image"] as! String)
                    if !self.myGroupsArray.contains(group) {
                        self.myGroupsArray.append(group)
                        print("the are append group \(group.name)")
                        self.myGroupsTableView.reloadData()
                    }
                }
            }
        }
        
        myGroupsTableView.rowHeight = CGFloat(self.avatarSetings.tableViewHeight)
        
        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
    }
}

extension MyGroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("""
            select my group "\(myGroupsArray[indexPath.row].name)"
            """)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        tableView.cellForRow(at: indexPath)?.transform = CGAffineTransform.identity.scaledBy(x: 1.4, y: 1.4)
                        tableView.cellForRow(at: indexPath)?.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
                        tableView.cellForRow(at: indexPath)?.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MyGroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myGroupsTableView.dequeueReusableCell(withIdentifier: "myGroupsIdentifire", for: indexPath) as! MyGroupsTableViewCell
        
        cell.myGroupsImageView.image = UIImage(named: myGroupsArray[indexPath.row].icon) 
        cell.myGroupsNameLabel.text = myGroupsArray[indexPath.row].name
        
        return cell
    }
    
    @IBAction func unwindToMyGroups(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "addGroupSegueIdentifier" {
            guard let allGroupController = unwindSegue.source as? AllGroupsViewController else {return}
            guard let indexPath = allGroupController.allGroupsTableView.indexPathForSelectedRow else {return}
            
            let group = allGroupController.allGroupsArray[indexPath.row]
            
            if !myGroupsArray.contains(where: {$0.name == group.name}) {
                myGroupsArray.append(allGroupController.filteredGroups[indexPath.row])
                ref.child("\(self.myGroupsArray.count - 1)").setValue(["name" : group.name, "image" : group.icon])
                myGroupsTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            myGroupsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ref.child("\(indexPath.row)").setValue(["name" : nil, "image" : nil])
            ref.child("groups").removeValue()
            for (i, j) in self.myGroupsArray.enumerated() {
                ref.child("\(i)").setValue(["name" : j.name, "image" : j.icon])
                ref.child("\(i + 1)").setValue(["name" : nil, "image" : nil])
            }
            
            print(indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        animateCells(tableView, cell: cell)
    }
}
