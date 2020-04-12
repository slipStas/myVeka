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
                                         with: .bottom)
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
        
        var urlImage = URL(string: news[indexPath.row].avatar )
        if urlImage == nil {
            urlImage = URL(string: "https://vk.com/images/camera_400.png?ava=1")
        }
        let urlImageNews = URL(string: news[indexPath.row].photos.first ?? "https://vk.com/images/camera_400.png?ava=1")
        let cacheKey = String(news[indexPath.row].id) + news[indexPath.row].avatar
        let cacheKeyImage = String(news[indexPath.row].avatar) + (news[indexPath.row].photos.first ?? "")
        
        cell.imageNewsView?.removeFromSuperview()
        
        cell.avatarOwnerNews.layer.masksToBounds = true
        cell.avatarOwnerNews.layer.cornerRadius = cell.avatarOwnerNews.frame.height / 2
        
        cell.textOfNews.isEditable = false
        cell.textOfNews.isScrollEnabled = true
        cell.avatarOwnerNews.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))
        
        cell.nameOwnerNewsLabel.text = news[indexPath.row].name
        cell.textOfNews.text = news[indexPath.row].text
        
        if self.news[indexPath.row].photos.isEmpty {
            cell.imageNewsView?.removeFromSuperview()
        } else {
            //cell.imageNewsView?.kf.setImage(with: ImageResource(downloadURL: urlImageNews!, cacheKey: cacheKeyImage))
        }
        
        if cell.textOfNews.contentSize.height >= 300 {
            myNewsTableView.rowHeight = 300
        } else {
            myNewsTableView.rowHeight = cell.textOfNews.contentSize.height + cell.avatarOwnerNews.frame.height + 40 + (cell.imageNewsView?.frame.height ?? 0)
        }
        let screenSize: CGSize = UIScreen.main.bounds.size
        let myView = UIView(frame: CGRect(x: 0, y: myNewsTableView.rowHeight, width: screenSize.width - 10, height: 100))
        myView.backgroundColor = .blue
        //cell.addSubview(myView)
        
        return cell
    }
}
