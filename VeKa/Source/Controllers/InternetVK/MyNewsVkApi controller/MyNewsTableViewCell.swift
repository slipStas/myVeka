//
//  MyNewsTableViewCell.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 31.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

enum TextSize {
    case full
    case low
}

class MyNewsTableViewCell: UITableViewCell {
    
    var textSize : TextSize = .full
    
    lazy var avatarOwnerImage : UIImageView = {
        let view = UIImageView(frame: CGRect(x: 8, y: 8, width: 50, height: 50))
        return view
    }()
    
    lazy var nameOwnerNewsLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 66, y: 16, width: self.frame.width - 66, height: 20))
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        let date = UILabel(frame: CGRect(x: 66, y: 34, width: self.frame.width - 66, height: 20))
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
    
    @objc func tapShowMore() {
        print("show less pressed")
        switch self.textSize {
        case .full:
            self.textSize = .low
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.textNewsLabel.frame = CGRect(x: self.textNewsLabel.frame.minX, y: self.textNewsLabel.frame.minY, width: self.textNewsLabel.frame.width, height: 200)
                            self.buttonInText.center.y -= self.textNewsLabel.optimalHeight - 200
                            self.imageNewsView.center.y -= self.textNewsLabel.optimalHeight - 200
                            self.contentView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - self.textNewsLabel.optimalHeight - 200)
                            self.buttonInText.setTitle("show more...", for: .normal)
            })
        case .low:
            self.textSize = .full
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.textNewsLabel.frame = CGRect(x: self.textNewsLabel.frame.minX, y: self.textNewsLabel.frame.minY, width: self.textNewsLabel.frame.width, height: self.textNewsLabel.optimalHeight)
                            self.buttonInText.center.y += self.textNewsLabel.optimalHeight - 200
                            self.imageNewsView.center.y += self.textNewsLabel.optimalHeight - 200
                            self.buttonInText.setTitle("show less...", for: .normal)
            })
        }
        
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()

        buttonInText.isEnabled = true
        buttonInText.isUserInteractionEnabled = true
        buttonInText.addTarget(self, action: #selector(tapShowMore), for: .touchUpInside)
    }
    
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
        addSubview(buttonInText)
    }
    
}

