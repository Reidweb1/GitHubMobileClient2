//
//  FromImageAnimator.swift
//  GitHub2Go
//
//  Created by Reid Weber on 10/23/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation
import UIKit

class FromImageAnimator: NSObject, UIViewControllerAnimatedTransitioning {
 
    var origin: CGRect?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UserDetailViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UserViewController
        
        let containerView = transitionContext.containerView()
        containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
        toViewController.view.alpha = 0.0
        
        fromViewController.view.frame = toViewController.view.bounds
        
        //toViewController.view.frame = fromViewController.reverseOrigin!
        //toViewController.view.frame = self.origin!
        //toViewController.imageView.frame = toViewController.view.bounds
        //fromViewController.view.frame = self.origin!
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: { () -> Void in
            fromViewController.view.frame = self.origin!
            toViewController.view.alpha = 1.0
            }) { (finished) -> Void in
                transitionContext.completeTransition(finished)
        }
    }
    
}
