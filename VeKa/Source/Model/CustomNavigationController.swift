//
//  CustomNavigationController.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 08.10.2019.
//  Copyright © 2019 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var hasStarted = false
    var shouldFinish = false
    
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let pushAnimator = CustomPushTransitionAnimator()
    let popAnimator = CustomPopTransitionAnimator()
    
    let interactiveTransition = CustomInteractiveTransition()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGesture(_:)))
        edgePanGR.edges = .left
        
        view.addGestureRecognizer(edgePanGR)
        
    }
    
    //MARK - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return pushAnimator
        case .pop:
            return popAnimator
        case .none:
            return nil
        @unknown default:
            fatalError()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    @objc func edgePanGesture(_ recogniser: UIScreenEdgePanGestureRecognizer) {
        switch recogniser.state {
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
            guard let width = recogniser.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            
            let translation = recogniser.translation(in: recogniser.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            interactiveTransition.shouldFinish = progress > 0.4
            interactiveTransition.update(progress)
            
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
        
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        default :
            break
        }
    }
}
