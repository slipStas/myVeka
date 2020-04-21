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
    
    lazy var dateLabel : UILabel = {
        let date = UILabel(frame: CGRect(x: 66, y: 45, width: self.frame.width - 66, height: 20))
        date.font = .systemFont(ofSize: 10)
        date.textColor = .gray
        
        return date
    }()
    
    lazy var textNewsLabel : UILabel = {
        let textView = UILabel(frame: .zero)
        textView.font = .systemFont(ofSize: 13)
        textView.numberOfLines = 0
        
        return textView
    }()
    
    lazy var buttonInText : UIButton = {
        let button = UIButton(frame: CGRect.zero)
        
        return button
    }()
    
    lazy var imageNewsView : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleToFill
        
        return image
    }()
   
    
    //MARK: prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.avatarOwnerImage.image = nil
        self.nameOwnerNewsLabel.text = nil
        self.imageNewsView.image = nil
        self.dateLabel.text = nil
        self.textNewsLabel.text = nil
        self.buttonInText.titleLabel?.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        addSubview(avatarOwnerImage)
        addSubview(nameOwnerNewsLabel)
        addSubview(imageNewsView)
        addSubview(dateLabel)
        addSubview(textNewsLabel)
        self.textNewsLabel.addSubview(buttonInText)
    }
}

