//
//  CustomSegue.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 08.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    let duration: TimeInterval = 0.5
    
    override func perform() {
        
        let height = source.view.frame.height
        let width = source.view.frame.width

        guard let containerView = source.view else {return}
        containerView.addSubview(destination.view)
        source.view.frame = containerView.frame
        destination.view.frame = containerView.frame
        let translation = CGAffineTransform(translationX: width * 1.5, y: -height)
        let rotation = CGAffineTransform(rotationAngle: 90)
        destination.view.transform = translation.concatenating(rotation)
        
        UIView.animate(withDuration: duration, animations: {
            self.destination.view.transform = .identity
        }, completion: { _ in
            self.source.present(self.destination, animated:  false)})
    }
    
}
