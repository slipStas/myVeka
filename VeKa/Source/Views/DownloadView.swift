//
//  DownloadView.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 07.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class Download: UIView {
    
    let color = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    let cloudPath = createBeziePath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        addLayerSnake()
        addCircleLayer()
    }
 
    private func addLayerSnake() {
        
        let myLayer = CAShapeLayer()
        myLayer.position = CGPoint(x: 0, y: 0)
        myLayer.path = cloudPath.cgPath
        
        myLayer.lineWidth = 2
        myLayer.strokeColor = color.cgColor
        myLayer.fillColor = UIColor.clear.cgColor
        myLayer.strokeEnd = 0
        
        self.layer.addSublayer(myLayer)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        strokeEndAnimation.fromValue = 0.001
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeIn)

        let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeEndAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.5
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [strokeEndAnimation, strokeStartAnimation]

        myLayer.add(animationGroup, forKey: nil)
    }
    
    private func addCircleLayer() {
        
        let circleColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        let circleLayer = CAShapeLayer()
        circleLayer.bounds = CGRect(x: 0, y: 0, width: heightWidthOfSubViews, height: heightWidthOfSubViews)
        circleLayer.position = CGPoint(x: 0, y: 0)
        circleLayer.cornerRadius = CGFloat(heightWidthOfSubViews / 2)
        circleLayer.backgroundColor = circleColor.cgColor
        
        self.layer.addSublayer(circleLayer)
        
        let animation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        animation.path = createBeziePath().cgPath
        animation.duration = 2.5
        animation.repeatCount = .infinity
        animation.calculationMode = .cubicPaced
        
        circleLayer.add(animation, forKey: nil)
    }
}

private func createBeziePath() -> UIBezierPath {
    
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 43.5, y: 74.5))
    
    bezierPath.addCurve(to: CGPoint(x: 50.5, y: 74.5), controlPoint1: CGPoint(x: 44.36, y: 74.32), controlPoint2: CGPoint(x: 57.62, y: 83.57))
    bezierPath.addCurve(to: CGPoint(x: 59.5, y: 19.5), controlPoint1: CGPoint(x: 28.5, y: 46.5), controlPoint2: CGPoint(x: 37.5, y: 13.5))
    bezierPath.addCurve(to: CGPoint(x: 80.5, y: 36.5), controlPoint1: CGPoint(x: 81.5, y: 25.5), controlPoint2: CGPoint(x: 80.5, y: 36.5))
    bezierPath.addCurve(to: CGPoint(x: 120.5, y: 11.5), controlPoint1: CGPoint(x: 80.5, y: 36.5), controlPoint2: CGPoint(x: 82.5, y: -0.5))
    bezierPath.addCurve(to: CGPoint(x: 136.5, y: 54.5), controlPoint1: CGPoint(x: 158.5, y: 23.5), controlPoint2: CGPoint(x: 136.5, y: 54.5))
    bezierPath.addCurve(to: CGPoint(x: 171.5, y: 54.5), controlPoint1: CGPoint(x: 136.5, y: 54.5), controlPoint2: CGPoint(x: 161.5, y: 44.5))
    bezierPath.addCurve(to: CGPoint(x: 182.5, y: 86.5), controlPoint1: CGPoint(x: 181.5, y: 64.5), controlPoint2: CGPoint(x: 209.5, y: 74.5))
    bezierPath.addCurve(to: CGPoint(x: 107.5, y: 74.5), controlPoint1: CGPoint(x: 155.5, y: 98.5), controlPoint2: CGPoint(x: 107.5, y: 74.5))
    bezierPath.addCurve(to: CGPoint(x: 114.5, y: 102.5), controlPoint1: CGPoint(x: 107.5, y: 74.5), controlPoint2: CGPoint(x: 132.5, y: 95.5))
    bezierPath.addCurve(to: CGPoint(x: 80.5, y: 86.5), controlPoint1: CGPoint(x: 96.5, y: 109.5), controlPoint2: CGPoint(x: 80.5, y: 86.5))
    bezierPath.addCurve(to: CGPoint(x: 24.5, y: 107.5), controlPoint1: CGPoint(x: 80.5, y: 86.5), controlPoint2: CGPoint(x: 34.5, y: 115.5))
    bezierPath.addCurve(to: CGPoint(x: 24.5, y: 77.5), controlPoint1: CGPoint(x: 14.5, y: 99.5), controlPoint2: CGPoint(x: 19.5, y: 80.5))
    bezierPath.addCurve(to: CGPoint(x: 38.81, y: 74.66), controlPoint1: CGPoint(x: 27.63, y: 75.62), controlPoint2: CGPoint(x: 34.27, y: 74.92))
    bezierPath.addCurve(to: CGPoint(x: 43.5, y: 74.5), controlPoint1: CGPoint(x: 41.53, y: 74.5), controlPoint2: CGPoint(x: 43.5, y: 74.5))
    bezierPath.addCurve(to: CGPoint(x: 43.5, y: 74.5), controlPoint1: CGPoint(x: 43.5, y: 74.5), controlPoint2: CGPoint(x: 41.71, y: 74.87))
   
    bezierPath.close()

    
    return bezierPath
}
