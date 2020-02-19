//
//  AllGroupsTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 14.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var allGroupImageView: UIImageView!
    
    @IBOutlet weak var allGroupLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        allGroupImageView.image = nil
        allGroupLabel.text = nil
    }
    
}
