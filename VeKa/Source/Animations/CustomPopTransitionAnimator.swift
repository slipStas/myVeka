//
//  CustomPopTransitionAnimator.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 08.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class CustomPopTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.35
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from), let destination = transitionContext.viewController(forKey: .to) else {return}
        
        let width = source.view.bounds.width
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        let translation = CGAffineTransform(translationX: -width / 2, y: 0)
        let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
        destination.view.transform = translation.concatenating(scale)
        
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [.calculationModePaced], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/3 * self.duration), animations: {
                let translation = CGAffineTransform(translationX: 0.75 * width, y: 0)
                let scale = CGAffineTransform(scaleX: 1.3, y: 1.3)
                source.view.transform = translation.concatenating(scale)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: (1/3 * self.duration), animations: {
                source.view.transform = CGAffineTransform(translationX: width, y: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: (1/3 * self.duration), animations: {
                destination.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
