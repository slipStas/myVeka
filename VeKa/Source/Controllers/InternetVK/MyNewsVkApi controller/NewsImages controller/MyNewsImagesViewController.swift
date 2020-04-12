//
//  MyNewsImagesViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 12.04.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import Kingfisher

class MyNewsImagesViewController: UIViewController {

    @IBOutlet weak var newsImagesCollection: UICollectionView!
    
    var newsImagesArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsImagesCollection.dataSource = self
    }
   
}

extension MyNewsImagesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsImagesCollection.dequeueReusableCell(withReuseIdentifier: "myNewsImages", for: indexPath) as! MyNewsImagesCollectionViewCell
        
//        var urlImage = URL(string: newsImagesArray[indexPath.row] )
//        if urlImage == nil {
//            urlImage = URL(string: "https://vk.com/images/camera_400.png?ava=1")
//        }
//        let cacheKey = String(newsImagesArray[indexPath.row])
        
        //cell.myNewsImage.kf.setImage(with: ImageResource(downloadURL: urlImage!, cacheKey: cacheKey))
        cell.myNewsImage.image = #imageLiteral(resourceName: "image_1")
        return cell
    }
    
}
