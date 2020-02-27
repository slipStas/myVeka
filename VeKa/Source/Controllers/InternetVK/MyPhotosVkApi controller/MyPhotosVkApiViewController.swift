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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 0.5)
        let width = (self.view.bounds.width - (minimumLineSpacing * countImagesInLine)) / countImagesInLine
        let layout = myPhotosVkApi.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumLineSpacing
        myPhotosVkApi.backgroundColor = backgroundColor
        
        
        self.myPhotosVkApi.dataSource = self
    }
}

extension MyPhotosVkApiViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myPhotosVkApi.dequeueReusableCell(withReuseIdentifier: "myPhotosVkApi", for: indexPath) as! MyPhotosVkApiCollectionViewCell
        
        cell.myPhotosVkApi.image = #imageLiteral(resourceName: "icon_6")
        
        return cell
    }
    
    
}
