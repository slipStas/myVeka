//
//  LikesView.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 23.09.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class LikesView: UIView {
    
    var likesStatus: Likes.LikesStatus = .noLike {
        didSet {
            switch likesStatus {
            case .like:
                UIView.animate(withDuration: 0.4, delay: 0.15, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: [], animations: {
                    self.likeIcon.image = UIImage(named: "heart_fill")
                    self.likesCount.textColor = UIColor.red
                    self.likeIcon.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
                })
                UIView.transition(with: likeIcon, duration: 0.3, options: .transitionCrossDissolve, animations: {})
                UIView.transition(with: likesCount, duration: 0.3, options: .transitionCrossDissolve, animations: {})
            case .noLike:
                UIView.animate(withDuration: 0.4, delay: 0.15, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: [], animations: {
                    self.likeIcon.image = UIImage(named: "heart")
                    self.likesCount.textColor = UIColor.darkText
                    self.likeIcon.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                })
                UIView.transition(with: likeIcon, duration: 0.3, options: .transitionCrossDissolve, animations: {})
                UIView.transition(with: likesCount, duration: 0.25, options: .transitionCrossDissolve, animations: {})
            }
        }
    }
    
    let likeIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))

    let likesCount = UILabel(frame: CGRect(x: 35, y: 0, width: (30 * 3), height: 30))
    
    
    var onTap: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(likesCount)
        addSubview(likeIcon)
        
        likeIcon.image = UIImage(named: "heart")
        likesCount.textColor = UIColor.darkText
        likesCount.backgroundColor = .clear
        
        let gr = UITapGestureRecognizer(target: self, action: #selector(tapOnLike(guestRecogniser:)))
        addGestureRecognizer(gr)
    }
    
    @objc func tapOnLike(guestRecogniser: UITapGestureRecognizer) {
        onTap?()
    }
}
