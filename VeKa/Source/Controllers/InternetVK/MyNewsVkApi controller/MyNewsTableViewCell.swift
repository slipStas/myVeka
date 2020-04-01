//
//  MyNewsTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 31.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class MyNewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avatarOwnerNews: UIImageView!
    @IBOutlet weak var nameOwnerNewsLabel: UILabel!
    @IBOutlet weak var textOfNews: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarOwnerNews.image = nil
        nameOwnerNewsLabel.text = nil
        textOfNews.text = nil

        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
}
