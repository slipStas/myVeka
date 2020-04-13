//
//  MyNewsViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 31.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class MyNewsViewController: UIViewController {
    
    @IBOutlet weak var myNewsTableView: UITableView!
    
    let news = Session.shared.realm.objects(NewsRealm.self)
    let getNews = GetNewsVkApi()
    let avatarSetings = AvatarSettings()
    var token : NotificationToken?
    var refreshControll = UIRefreshControl()
    
    func pairTableAndRealm() {
        
        token = self.news.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.myNewsTableView else { return }
            switch changes {
            case .initial(let changedData):
                if self?.news.count != changedData.count {
                    tableView.reloadData()
                }
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                if insertions.count > 0 {
                    print("update tableView")
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .bottom)
                }
                if deletions.count > 0 {
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .left)
                }
                if modifications.count > 0 {
                    print("modification tableView")
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                }
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    @objc func updateNews() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.getNews.getNews { (state) in
                if state {
                    print("news was refreshed")
                } else {
                    print("Error with data from Realm")
                }
                self.pairTableAndRealm()
                self.refreshControll.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        myNewsTableView.refreshControl = refreshControll
        refreshControll.attributedTitle = NSAttributedString(string: "Updating news")
        refreshControll.addTarget(self, action: #selector(updateNews), for: .valueChanged)
        
        if self.news.count == 0 {
            
            DispatchQueue.main.async {
                self.getNews.getNews { (state) in
                    if state {
                        print("news was added")
                    } else {
                        print("Error with data from Realm")
                    }
                }
                self.pairTableAndRealm()
            }
        }
        myNewsTableView.dataSource = self
    }
}


extension MyNewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myNewsTableView.dequeueReusableCell(withIdentifier: "myNewsTable", for: indexPath) as! MyNewsTableViewCell
        
        myNewsTableView.rowHeight = cell.avatarOwnerImage.frame.height + 16
        
        let urlImage = URL(string: news[indexPath.row].avatar)
       
        let cacheKey = String(news[indexPath.row].id) + news[indexPath.row].avatar
        
        let urlImageNews = URL(string: news[indexPath.row].photos.first ?? "https://vk.com/images/camera_400.png?ava=1")
    
        let cacheKeyNews = String(news[indexPath.row].avatar) + (news[indexPath.row].photos.first ?? "0")
        
        cell.avatarOwnerImage.layer.masksToBounds = true
        cell.avatarOwnerImage.layer.cornerRadius = cell.avatarOwnerImage.frame.height / 2
        cell.avatarOwnerImage.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))

        cell.nameOwnerNewsLabel.text = news[indexPath.row].name
       
        cell.textView.text = news[indexPath.row].text
        cell.textView.isEditable = false
        
        cell.imageNewsView.layer.masksToBounds = true
        cell.imageNewsView.layer.cornerRadius = cell.imageNewsView.frame.width / 20
        
        if cell.textView.text.isEmpty {
            cell.textView.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + 16, width: cell.contentView.frame.width - 16, height: 0)
        }
        
        if cell.textView.contentSize.height >= 300 {
            cell.textView.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + 16, width: cell.contentView.frame.width - 16, height: 300)
            myNewsTableView.rowHeight += cell.textView.frame.height + 8
        } else {
            cell.textView.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + 16, width: cell.contentView.frame.width - 16, height: cell.textView.contentSize.height)
            myNewsTableView.rowHeight += cell.textView.frame.height + 8
        }
        
        
        
        if news[indexPath.row].photos.isEmpty {
            cell.imageNewsView.removeFromSuperview()
        } else {
            let heightText = cell.textView.frame.height + cell.avatarOwnerImage.frame.height + 24
            cell.imageNewsView.frame = CGRect(x: 8, y: 8 + heightText, width: self.view.frame.width - 16, height: self.view.frame.width - 16)
            cell.imageNewsView.kf.setImage(with: ImageResource(downloadURL: urlImageNews!, cacheKey: cacheKeyNews))
            myNewsTableView.rowHeight += cell.imageNewsView.frame.height + 16
        }
        return cell
    }
}
