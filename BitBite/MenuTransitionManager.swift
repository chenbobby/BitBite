//
//  MenuTransitionManager.swift
//  BitBite
//
//  Created by Bobby Chen on 3/11/17.
//  Copyright © 2017 BMStudios. All rights reserved.
//

import UIKit


class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration = 0.5
    var isPresenting = false
    
    var snapshot:UIView? {
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: #selector(MenuTransitionManagerDelegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    var delegate:MenuTransitionManagerDelegate?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // Set up the transform for sliding
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        
        // Add both views to the container view
        if isPresenting {
            toView.transform = moveUp
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
            
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
        
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
}

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}
