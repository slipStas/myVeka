//
//  MyPhotosVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class MyPhotosVkApiViewController: UIViewController {
    
    @IBOutlet weak var myPhotosVkApi: UICollectionView!
    
    let countImagesInLine: CGFloat = 3
    var minimumLineSpacing: CGFloat = 1
    
    let myPhotos = GetMyPhotosVkApi()
    let photos = Session.shared.realm.objects(MyPhotosRealm.self)
    var token : NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (self.view.bounds.width - (minimumLineSpacing * countImagesInLine)) / countImagesInLine
        let layout = myPhotosVkApi.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumLineSpacing
        
        myPhotos.getPhotos { (state) in
            if state {
                self.myPhotosVkApi.reloadData()
            } else {
                print("Error with data from Realm")
            }
        }
        self.myPhotosVkApi.dataSource = self
    }
}

extension MyPhotosVkApiViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myPhotosVkApi.dequeueReusableCell(withReuseIdentifier: "myPhotosVkApi", for: indexPath) as! MyPhotosVkApiCollectionViewCell
        
        let urlImage = URL(string: photos[indexPath.row].photo)
        let cacheKey = String(photos[indexPath.row].id) + photos[indexPath.row].photo
        
        cell.myPhotosVkApi.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))
        
        return cell
    }
}
