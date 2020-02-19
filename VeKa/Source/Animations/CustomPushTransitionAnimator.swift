//
//  CustomPushTransitionAnimator.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 08.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class CustomPushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from), let destination = transitionContext.viewController(forKey: .to) else {return}
        
        let width = source.view.bounds.width
        let height = source.view.bounds.height
        
        transitionContext.containerView.addSubview(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        let translation = CGAffineTransform(translationX: width, y: height)
        let rotation = CGAffineTransform(rotationAngle: -90)
        destination.view.transform = translation.concatenating(rotation)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModePaced], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/2 * self.duration), animations: {

                let translation = CGAffineTransform(translationX: -width, y: height)
                let rotation = CGAffineTransform(rotationAngle: 90)
                source.view.transform = translation.concatenating(rotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: (1/2 * self.duration), animations: {
                destination.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
