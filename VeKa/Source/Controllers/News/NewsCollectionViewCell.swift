//
//  NewsCollectionViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 28.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsCollectionImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsCollectionImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsCollectionImage.frame = frame
    }
    
}
