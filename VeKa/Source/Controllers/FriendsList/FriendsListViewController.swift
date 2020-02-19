//
//  FriendsListViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 13.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class FriendsListViewController: UIViewController {
    
    var friendsArray: [User] = []
    var friendsFiltered: [User] = []
    
    var sections: [String] = []
    var friendsInSections: [String: [User]] = [:]
    
    private var selectedFriend: User?
    
    @IBOutlet weak var friendsListTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsListTableView.rowHeight = 66
        
        friendsListTableView.dataSource = self
        friendsListTableView.delegate = self
        
        addUsers()
        addPhotos()
        
        friendsListTableView.register(UINib(nibName: "Header", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        
        self.friendsFiltered = self.friendsArray
        
        fillSections()
        fillSectionsWithFriends()
        
    }
    
    func addUsers() {
        friendsArray.append(User(name: "Valera", avatar: (UIImage(named: "image_1")!), likes: Likes(likesCounts: 490, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Valera", avatar: (UIImage(named: "image_4")!), likes: Likes(likesCounts: 8, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Igor", avatar: (UIImage(named: "image_2")!), likes: Likes(likesCounts: 10, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Elena", avatar: (UIImage(named: "image_3")!), likes: Likes(likesCounts: 7653, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Oleg", avatar: (UIImage(named: "image_4")!), likes: Likes(likesCounts: 9719, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Mikhail", avatar: (UIImage(named: "image_5")!), likes: Likes(likesCounts: 54, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "John", avatar: (UIImage(named: "image_1")!), likes: Likes(likesCounts: 567, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Stanislav", avatar: (UIImage(named: "image_2")!), likes: Likes(likesCounts: 4568, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Olga", avatar: (UIImage(named: "image_3")!), likes: Likes(likesCounts: 1, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Viktor", avatar: (UIImage(named: "image_4")!), likes: Likes(likesCounts: 423, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Denis", avatar: (UIImage(named: "image_5")!), likes: Likes(likesCounts: 974, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Alex", avatar: (UIImage(named: "image_1")!), likes: Likes(likesCounts: 1113, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Alexander", avatar: (UIImage(named: "image_2")!), likes: Likes(likesCounts: 96528, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Julia", avatar: (UIImage(named: "image_3")!), likes: Likes(likesCounts: 100000, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Valera", avatar: (UIImage(named: "image_5")!), likes: Likes(likesCounts: 490, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Pavel", avatar: (UIImage(named: "image_4")!), likes: Likes(likesCounts: 2, likeStatus: .noLike), photos: []))
        friendsArray.append(User(name: "Anton", avatar: (UIImage(named: "image_5")!), likes: Likes(likesCounts: 89, likeStatus: .noLike), photos: []))
    }
    
    func addPhotos() {
        for i in friendsArray {
            let randomCount = Int.random(in: 10...35)
            let array = Array(repeating: i.avatar, count: randomCount)
            i.photos.append(contentsOf: array)
        }
    }
}

extension FriendsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = friendsListTableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! Header
        
        header.backgroundView = UIView(frame: header.bounds)
        header.backgroundView?.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        header.backgroundView?.alpha = 0.1
        header.headerLabel.alpha = 0.6
        header.headerLabel.text = sections[section]
    
        return header
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //animateAlphaTable(tableView: friendsListTableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionName: String = self.sections[indexPath.section]
        if let friendsInSection: [User] = self.friendsInSections[sectionName] {
            print("""
            select friend "\(friendsInSection[indexPath.row].name)"
            """)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FriendsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName: String = self.sections[section]
        if let friendsInSection: [User] = self.friendsInSections[sectionName] { return friendsInSection.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsListTableView.dequeueReusableCell(withIdentifier: "friendsListIdentifire", for: indexPath) as! FriendsListTableViewCell
        
        
        let sectionName: String = self.sections[indexPath.section]
        if let friendsInSection: [User] = self.friendsInSections[sectionName] {
            cell.friendNameLabel.text = friendsInSection[indexPath.row].name
            cell.friendsPhotoImageView.image = friendsInSection[indexPath.row].avatar
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "showFriendInfo" {
            if let indexPath = friendsListTableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination  as? FriendInfoViewController {
                    let sectionName: String = self.sections[indexPath.section]
                    if let friendsInSection: [User] = self.friendsInSections[sectionName] {
                        destinationVC.friendInfoList = [(friendsInSection[(indexPath as NSIndexPath).row])]

                    }
                }
            }
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
    func filter(query: String) {
        friendsFiltered.removeAll()
        
        var isInFilter = true
        
        for friend in friendsArray {
            if query.count > 0 { isInFilter = (friend.name.lowercased().contains(query.lowercased())) }
            if isInFilter { friendsFiltered.append(friend) }
        }
        
        fillSections()
        fillSectionsWithFriends()
    }
    
    func fillSections() {
        sections = Array(Set(friendsFiltered.map { String(($0.name.first)!) })).sorted()
    }
    
    func fillSectionsWithFriends() {
        friendsInSections.removeAll()
        
        for friend in friendsFiltered {
            guard let firstLetter = friend.name.first else { continue }
            
            var friends: [User] = []
            
            if let friendsInSection = friendsInSections[String(firstLetter)] {
                friends.append(contentsOf: friendsInSection)
            }
            
            friends.append(friend)
            
            friendsInSections[String(firstLetter)] = friends
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        animateCells(tableView, cell: cell)
    }
}

