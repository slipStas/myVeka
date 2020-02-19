//
//  LoadingView.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 03.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

let heightWidthOfSubViews = 10
let distanceBeetwenSubViews = heightWidthOfSubViews * 3
var circlesCount = 0


class Circle: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let colorStroke = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        let colorFill = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: CGRect(x: heightWidthOfSubViews / 2, y: heightWidthOfSubViews / 2, width: heightWidthOfSubViews, height: heightWidthOfSubViews))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(colorFill.cgColor)
        context.setStrokeColor(colorStroke.cgColor)
        path.lineWidth = 2
        path.stroke()
        path.fill()
    }
}

class LoadingView: UIView {
    
    var views: [Circle] = []
    var lastCoordinateX = 10
    
    private func addMyViews() {
        
        circlesCount = Int(self.frame.width) / (distanceBeetwenSubViews + heightWidthOfSubViews - 10)
        for _ in 0..<circlesCount {
            let view = Circle(frame: CGRect(x: lastCoordinateX + (heightWidthOfSubViews / 2), y: heightWidthOfSubViews / 2, width: heightWidthOfSubViews + 10, height: heightWidthOfSubViews + 10))
            view.tintColor = .black
            view.backgroundColor = .clear
            view.alpha = 0.1
            views.append(view)
            lastCoordinateX += distanceBeetwenSubViews
        }
    }
    
    private func animation() {
        let delay = views.count
        var count = 0
        
        for i in views {
            UIView.animate(withDuration: 0.55, delay: Double(count) / Double(delay), options: [.repeat, .autoreverse], animations: {
                i.alpha = 0.7
                i.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
                count += 1
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addMyViews()
        for i in views {
            addSubview(i)
        }
        let newFrame = CGRect(x: 0, y: 0, width: 500, height: 60)
        frame = newFrame
        
        backgroundColor = .clear
        animation()
    }
}
