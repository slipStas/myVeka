//
//  NewsTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 28.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var arrayPhotos: [UIImage] = []
    
    @IBOutlet weak var newsText: UILabel!
    
    @IBOutlet weak var newsLikeView: LikesView!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let width = frame.width
        let layout = newsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsText.text = nil
        newsLikeView.likeIcon.image = nil
        newsLikeView.likesCount.text = nil
        
    }
    
}

