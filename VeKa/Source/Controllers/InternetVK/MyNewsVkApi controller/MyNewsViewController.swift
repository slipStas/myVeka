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
        
        var urlImage = URL(string: news[indexPath.row].avatar )
        if urlImage == nil {
            urlImage = URL(string: "https://vk.com/images/camera_400.png?ava=1")
        }
        let cacheKey = String(news[indexPath.row].id) + news[indexPath.row].avatar
        
        cell.avatarOwnerImage.layer.masksToBounds = true
        cell.avatarOwnerImage.layer.cornerRadius = cell.avatarOwnerImage.frame.height / 2
        cell.avatarOwnerImage.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))

//        cell.nameOwnerNewsLabel.text = news[indexPath.row].name
        
        self.myNewsTableView.rowHeight = 300//16 + cell.avatarOwnerNews.frame.height
        
        //let screenSize: CGSize = UIScreen.main.bounds.size
        
        if !news[indexPath.row].text.isEmpty {
//            let textView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
//            textView.backgroundColor = .red
//            cell.addSubview(textView)
            
            // Creating constraints using NSLayoutConstraint
//            NSLayoutConstraint(item: textView,
//                               attribute: .leading,
//                               relatedBy: .equal,
//                               toItem: cell.contentView,
//                               attribute: .leadingMargin,
//                               multiplier: 1.0,
//                               constant: 8.0).isActive = true
//
//            NSLayoutConstraint(item: textView,
//                               attribute: .trailing,
//                               relatedBy: .equal,
//                               toItem: cell.contentView,
//                               attribute: .trailingMargin,
//                               multiplier: 1.0,
//                               constant: 8).isActive = true
//
//            NSLayoutConstraint(item: textView,
//                               attribute: .top,
//                               relatedBy: .equal,
//                               toItem: cell.avatarOwnerNews,
//                               attribute: .bottomMargin,
//                               multiplier: 1.0,
//                               constant: 10.0).isActive = true
//
//            let margins = cell.contentView.layoutMarginsGuide
//
//            textView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
//            textView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//            textView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//            textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            //textView.text = news[indexPath.row].text

        }

        /*
        cell.textOfNews.isEditable = false
        cell.textOfNews.isScrollEnabled = true
        
        cell.textOfNews.text = news[indexPath.row].text
        
        if cell.textOfNews.contentSize.height >= 300 {
            myNewsTableView.rowHeight = 300
        } else {
            myNewsTableView.rowHeight = cell.textOfNews.contentSize.height + cell.avatarOwnerNews.frame.height + 32
        }
         */
        
        return cell
    }
}
