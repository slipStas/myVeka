//
//  MyNewsTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 31.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class MyNewsTableViewCell: UITableViewCell {

    lazy var avatarOwnerImage : UIImageView = {
        let view = UIImageView(frame: CGRect(x: 8, y: 8, width: 100, height: 100))
        return view
    }()
   
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarOwnerImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        addSubview(avatarOwnerImage)
    }
}
