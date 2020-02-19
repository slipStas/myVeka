//
//  NewsViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 28.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsArray: [News] = []
    var sectionsCount = 0

    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.dataSource = self
        newsTableView.delegate = self
        
        newsTableView.frame.size.width = view.frame.width
                
        addNews()
        
    }
    
    func addNews() {
        newsArray.append(News(images: [UIImage(named: "news_1")!, UIImage(named: "news_1")!, UIImage(named: "news_1")!], newsText: "Млечный Путь, Туманность Киля, Южный Крест, звезды Центавра и другие сокровища южного неба!\nФото © Okan Can Bozat", likesCount: 9863))
        newsArray.append(News(images: [UIImage(named: "news_2")!, UIImage(named: "news_2")!], newsText: "Портал Domofond провел опрос жителей столицы, чтобы выяснить какой район Москвы самый худший. Москвичи оценивали по 10-балльной шкале утверждения, которые характеризуют безопасность, чистоту, экологию, общественный транспорт, тишину, дороги и парковки в разных районах столицы.\nПобедил (если можно так сказать) район Люблино — он получил минимальную общую оценку: 5,2 балла из десяти возможных. Респонденты отметили, что в местных дворах грязно, районные службы ЖКХ работают плохо — как и общественный транспорт, а качество люблинского воздуха оставляет желать лучшего.\nВ десятку худших также попали районы Кузьминки, Дмитровский, Бирюлево Западное, Рязанский, Зябликово, Печатники, Западное Дегунино, Восточное Дегунино и Ярославский.\nА вот лучшим для жизни москвичи выбрали Строгино: район набрал 8,9 балла. На втором месте в списке лидеров Хорошевский район с 8,5 балла, а на третьем — Крылатское с 8,3 балла. От него незначительно отстают Раменки. Кроме перечисленных, в топ-10 вошли районы Головинский, Академический, Южное Бутово, Ломоносовский, Митино и Тропарево-Никулино.", likesCount: 4220986))
        newsArray.append(News(images: [UIImage(named: "news_3")!], newsText: "Уже через 8 часов! Расписание лунного затмения (время московское).\nНачало полутеневого затмения: 5:37\nНачало частного теневого затмения: 6:30\nНачало полного теневого затмения: 7:41\nМаксимальная фаза теневого затмения: 8:12\nОкончание полного теневого затмения: 8:44\nОкончание частного теневого затмения: 9:21\nОкончание полутеневого затмения: 10:51", likesCount: 999985))
        newsArray.append(News(images: [UIImage(named: "news_4")!], newsText: "Такие черные лампы — 'blackout bulbs' — были изобретены в конце 1930-х и применялись во время Второй мировой. Они полностью покрыты черной краской, и только снизу есть небольшой прозрачный участок. При ночных авианалетах, во время т. н. 'блэкаутов', по тревоге полагалось выкрутить обычные лампочки и вставить вот такие специальные, а окна завесить плотными шторами. Слабого света этих ламп хватало, чтобы заниматься делами, но снаружи он был практически не виден, и вражеские пилоты не могли ориентироваться по огням городов.", likesCount: 207))
        sectionsCount = newsArray.count
    }

}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsIdentifier", for: indexPath) as! NewsTableViewCell
        
        cell.arrayPhotos = newsArray[indexPath.row].images
        
        cell.newsCollectionView.dataSource = self
        cell.newsCollectionView.reloadData()
        
        cell.newsText.text = newsArray[indexPath.section].newsText
        cell.newsLikeView.likesCount.text = String(newsArray[indexPath.section].likes.likesCounts)
        
        switch self.newsArray[indexPath.section].likes.likeStatus {
        case .like:
            cell.newsLikeView.likesStatus = .like
        case .noLike:
            cell.newsLikeView.likesStatus = .noLike
        }
        
        cell.newsLikeView.onTap = {
            
            if cell.newsLikeView.likesStatus == .noLike {
                self.newsArray[indexPath.section].likes.likesCounts += 1
                self.newsArray[indexPath.section].likes.likeStatus = .like
                self.newsTableView.reloadData()
            } else {
                self.newsArray[indexPath.section].likes.likesCounts -= 1
                self.newsArray[indexPath.section].likes.likeStatus = .noLike
                self.newsTableView.reloadData()
            }
        }
        
        return cell
    }
}

extension NewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray[section].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
        
        cell.newsCollectionImage.image = newsArray[indexPath.section].images[indexPath.row]
        
        return cell
    }
}
