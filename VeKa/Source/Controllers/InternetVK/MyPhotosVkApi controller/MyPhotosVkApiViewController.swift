//
//  MyPhotosVkApiViewController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class MyPhotosVkApiViewController: UIViewController {

    @IBOutlet weak var myPhotosVkApi: UICollectionView!
    
    let countImagesInLine: CGFloat = 3
    var minimumLineSpacing: CGFloat = 1
    
    let myPhotos = GetMyPhotosVkApi()
    var myPhotosVkApiArray : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (self.view.bounds.width - (minimumLineSpacing * countImagesInLine)) / countImagesInLine
        let layout = myPhotosVkApi.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumLineSpacing
        
        myPhotos.getPhotos { (photosItems, photosArray) in
            self.myPhotosVkApiArray.append(contentsOf: photosArray)
            self.myPhotosVkApi.reloadData()
        }
        
        self.myPhotosVkApi.dataSource = self
    }
}

extension MyPhotosVkApiViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPhotosVkApiArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myPhotosVkApi.dequeueReusableCell(withReuseIdentifier: "myPhotosVkApi", for: indexPath) as! MyPhotosVkApiCollectionViewCell
        
        cell.myPhotosVkApi.image = myPhotosVkApiArray[indexPath.row]
        
        return cell
    }
    
    
}
