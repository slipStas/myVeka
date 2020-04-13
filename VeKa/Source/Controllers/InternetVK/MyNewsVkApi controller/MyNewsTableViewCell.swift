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
        let view = UIImageView(frame: CGRect(x: 8, y: 8, width: 50, height: 50))
        return view
    }()
    
    lazy var nameOwnerNewsLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 66, y: 25, width: self.frame.width - 66, height: 20))
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var textView : UITextView = {
        let textView = UITextView(frame: CGRect(x: 8, y: 66, width: self.frame.width, height: 300))
        textView.font = .systemFont(ofSize: 13)
        return textView
    }()
    
    lazy var imageNewsView : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width))
        image.layer.masksToBounds = true
        image.layer.cornerRadius = self.imageNewsView.frame.width / 10
        return image
    }()
   
    
    //MARK: prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarOwnerImage.image = nil
        self.nameOwnerNewsLabel.text = nil
        self.textView.text = nil
        self.imageNewsView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        addSubview(avatarOwnerImage)
        addSubview(nameOwnerNewsLabel)
        addSubview(textView)
        addSubview(imageNewsView)
    }
}
