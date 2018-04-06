//
//  preloaderSpinnerTransition.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import UIKit


protocol controllerAnimationDelegate:class {
    func controllerTransitionBeginPresent()
    func controllerTransitionBeginDismissed()
}

class preloaderSpinnerTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting:Bool = true
    var leftSide:Bool = false
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if(presenting){
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            let container = transitionContext.containerView
            let openAnim = CGAffineTransform(scaleX: 1, y: 1)
            
            container.addSubview(toView)
            
            let startAnim = CGAffineTransform(scaleX: 0.7, y: 0.7)
            UIView.animate(withDuration: 0) {
                toView.transform = startAnim
                toView.alpha = 0.0
            }
            
            let duration = self.transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: { () -> Void in
                toView.transform = openAnim
                toView.alpha = 1
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
            }
        }else {
            let fromView = transitionContext.view(forKey:UITransitionContextViewKey.from)!
            let container = transitionContext.containerView
            container.addSubview(fromView)
            
            let closeAnim = CGAffineTransform(scaleX: 2, y: 2)
            
            let duration = self.transitionDuration(using: transitionContext)
            UIView.animate(withDuration: duration, animations: { () -> Void in
                fromView.transform = closeAnim
                fromView.alpha = 0.1
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
            }
        }
        
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
