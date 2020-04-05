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
        
        myNewsTableView.rowHeight = 200
        
        if self.news.count == 0 {
            
            getNews.getNews { (state) in
                if state {
                    print("news was added")
                } else {
                    print("Error with data from Realm")
                }
            }
        }
        myNewsTableView.dataSource = self
        pairTableAndRealm()
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
            urlImage = URL(string: "https://sun9-30.userapi.com/c840527/v840527644/2aa1c/cWRbJ1CDI08.jpg")
        }
        let cacheKey = String(news[indexPath.row].id) + news[indexPath.row].avatar
        
        cell.avatarOwnerNews.layer.masksToBounds = true
        cell.avatarOwnerNews.layer.cornerRadius = cell.avatarOwnerNews.frame.height / 2
        
        cell.textOfNews.isEditable = false
        cell.textOfNews.isScrollEnabled = true
        cell.avatarOwnerNews.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))

        cell.nameOwnerNewsLabel.text = news[indexPath.row].name
        cell.textOfNews.text = news[indexPath.row].text
        
        return cell
    }
    
    
}
