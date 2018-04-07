//
//  preloader.swift
//  preloaderSpinner
//
//  Created by namik kaya on 7.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import UIKit

protocol preloaderDelegate:class {
    func preloaderClose();
    func preloaderOpen();
}

class preloader:NSObject, preloaderSpinnerDelegate {
    weak var preloaderListener:preloaderDelegate?
    internal func preloaderSpinnerClose() {
        preloaderListener?.preloaderClose()
    }
    
    override init() {
        super.init()
    }
    
    weak var delegate: UIViewController?
    let transitionManager = preloaderSpinnerTransition()
    
    public func begin(){
        preloaderListener = delegate as? preloaderDelegate
        let controller = preloaderSpinner()
        controller.delegate = self
        controller.modalPresentationStyle = .overFullScreen
        controller.transitioningDelegate = transitionManager
        delegate?.present(controller, animated: true, completion: nil)
        preloaderListener?.preloaderOpen()
    }
    
}
