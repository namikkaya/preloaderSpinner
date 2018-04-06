//
//  TransitionManager.swift
//  seriTweet
//
//  Created by namik kaya on 23.11.2016.
//  Copyright © 2016 namik kaya. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    private var presenting:Bool = true
    var leftSide:Bool = false
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey:UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y:0)
        
        let offScreenLeft = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        if !leftSide {
            if self.presenting {
                toView.layer.zPosition=1;
                toView.transform = offScreenRight
            } else {
                toView.transform = offScreenLeft
            }
        } else {
            if self.presenting {
                toView.transform = offScreenLeft
            } else {
                toView.transform = offScreenRight
                toView.layer.zPosition=0;
            }
        }
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            if !self.leftSide {
                if self.presenting {
                    fromView.transform = offScreenLeft
                } else {
                    container.sendSubview(toBack: fromView)
                    fromView.transform = offScreenRight
                }
            } else {
                if self.presenting {
                    fromView.transform = offScreenRight
                    container.sendSubview(toBack: fromView)
                } else {
                    fromView.transform = offScreenLeft
                }
            }
            
            toView.transform = CGAffineTransform.identity
        }) { (finished) -> Void in
            transitionContext.completeTransition(true)
        }
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
