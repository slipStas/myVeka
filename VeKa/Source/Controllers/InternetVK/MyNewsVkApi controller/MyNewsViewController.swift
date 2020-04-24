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
                if modifications.count > 0 {
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                }
                if insertions.count > 0 {
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .bottom)
                }
                if deletions.count > 0 {
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .left)
                }
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    @objc func updateNews() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.getNews.getNews(table: self.myNewsTableView) { (state) in
                if state {
                    self.pairTableAndRealm()
                } else {
                    print("Error with data from server")
                }
                
                self.refreshControll.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myNewsTableView.refreshControl = refreshControll
        refreshControll.attributedTitle = NSAttributedString(string: "Updating news")
        refreshControll.addTarget(self, action: #selector(updateNews), for: .valueChanged)
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.getNews.getNews(table: self.myNewsTableView) { (state) in
                if state {
                    self.pairTableAndRealm()
                } else {
                    print("Error with data from server")
                }
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
        
        let urlImage = URL(string: news[indexPath.row].avatar)
        let cacheKey = String(news[indexPath.row].id) + news[indexPath.row].avatar
        let urlImageNews = URL(string: news[indexPath.row].photos.first?.url ?? "https://vk.com/images/camera_400.png?ava=1")
        let cacheKeyNews = String(news[indexPath.row].avatar) + (news[indexPath.row].photos.first?.url ?? "0")
        
        cell.avatarOwnerImage.layer.masksToBounds = true
        cell.avatarOwnerImage.layer.cornerRadius = cell.avatarOwnerImage.frame.height / 2
        cell.avatarOwnerImage.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))
        
        cell.nameOwnerNewsLabel.text = news[indexPath.row].name
        
        let timeResult = news[indexPath.row].date
        let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEE, d MMM, yy, HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let localDate = dateFormatter.string(from: date)
        
        cell.dateLabel.text = localDate
        
        myNewsTableView.rowHeight = cell.avatarOwnerImage.frame.height + 16
        
        cell.textNewsLabel.text = news[indexPath.row].text
        
        if cell.textNewsLabel.text!.isEmpty {
            cell.textNewsLabel.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + 16, width: cell.contentView.frame.width - 16, height: 0)
            cell.textNewsLabel.removeFromSuperview()
        } else if cell.textNewsLabel.optimalHeight >= 200 {
            cell.textNewsLabel.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + 16, width: cell.contentView.frame.width - 16, height: cell.textNewsLabel.optimalHeight + 15)
            cell.buttonInText.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + cell.textNewsLabel.frame.height + 8, width: 80, height: 20)
            cell.buttonInText.setTitle("Show less...", for: .normal)
            cell.buttonInText.setTitleColor(.systemBlue, for: .normal)
            cell.buttonInText.titleLabel?.font = .systemFont(ofSize: 13)            
            
            myNewsTableView.rowHeight += cell.textNewsLabel.frame.height + cell.buttonInText.frame.height
        } else {
            cell.textNewsLabel.frame = CGRect(x: 8, y: cell.avatarOwnerImage.frame.height + 16, width: cell.contentView.frame.width - 16, height: cell.textNewsLabel.optimalHeight + 15)
            myNewsTableView.rowHeight += cell.textNewsLabel.frame.height + 8
        }
        
        if news[indexPath.row].photos.isEmpty {
            cell.imageNewsView.frame = CGRect(x: 8, y: 8, width: 0, height: 0)
            cell.imageView?.removeFromSuperview()
        } else {
            var heightText: CGFloat = 0
            heightText = cell.textNewsLabel.frame.height + cell.avatarOwnerImage.frame.height + cell.buttonInText.frame.height + 16
            
            cell.imageNewsView.frame = CGRect(x: 8, y: heightText, width: self.view.frame.width - 16, height: (self.view.frame.width - 16) * CGFloat(news[indexPath.row].photos.first!.aspectRatio))
            cell.imageNewsView.kf.setImage(with: ImageResource(downloadURL: urlImageNews!, cacheKey: cacheKeyNews))
            cell.imageNewsView.layer.masksToBounds = true
            cell.imageNewsView.layer.cornerRadius = 5
            myNewsTableView.rowHeight += cell.imageNewsView.frame.height + 8
        }
        
        return cell
    }
}
