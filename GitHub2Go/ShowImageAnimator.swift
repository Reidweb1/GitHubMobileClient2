//
//  UserImageAnimator.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/23/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation

import UIKit

class ShowImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var origin: CGRect?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserDetailViewController
        
        let containerView = transitionContext.containerView()
        
        toViewController.view.frame = self.origin!
        toViewController.imageView.frame = toViewController.view.bounds
        
        containerView.addSubview(toViewController.view)
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            toViewController.view.frame = fromViewController.view.frame
            }) { (finished) -> Void in
                transitionContext.completeTransition(finished)
        }
    }
}