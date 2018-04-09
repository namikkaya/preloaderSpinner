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
    func preloaderClosed()
}

class preloader:NSObject, preloaderSpinnerDelegate {
    
    var transitionManager:preloaderSpinnerTransition!
    
    var controller:preloaderSpinner?
    weak var delegate: UIViewController?
    
    private var spinnerColorHolder:UIColor = UIColor.red
    /// En dıştaki dönen topaç rengi
    var cSpinnerColor:UIColor{
        set{
            spinnerColorHolder = newValue
        }get{
            return spinnerColorHolder
        }
    }
    
    private var trackerColorHolder:UIColor = UIColor.gray
    /// En dış topaç rayı rengi
    var trackerColor:UIColor {
        set{
            trackerColorHolder = newValue
        }get{
            return trackerColorHolder
        }
    }
    
    private var backgroundColorHolder:UIColor = UIColor.black.withAlphaComponent(0.3)
    
    /// Arkaplan rengi
    var backgroundColor:UIColor {
        set{
            backgroundColorHolder = newValue
        }get{
            return backgroundColorHolder
        }
    }
    
    private var bSpinnerColorHolder:UIColor = UIColor.green
    /// Ortadaki topaç rengi
    var bSpinnerColor:UIColor {
        set{
            bSpinnerColorHolder = newValue
        }get{
            return bSpinnerColorHolder
        }
    }
    
    
    private var aSpinnerColorHolder:UIColor = UIColor.white
    /// İç taraftaki topaç rengi
    var aSpinnerColor:UIColor {
        set{
            aSpinnerColorHolder = newValue
        }get{
            return aSpinnerColorHolder
        }
    }
    
    override init() {
        super.init()
        transitionManager = preloaderSpinnerTransition()
    }
    
    // bu class için referans
    private weak var preloaderListener:preloaderDelegate?
    
    /// Açmak için kullanılır.
    public func begin(){
        preloaderListener = delegate as? preloaderDelegate
        controller = preloaderSpinner()
        controller?.delegate = self
        controller?.backgroundColor = backgroundColor
        controller?.spinnerColor = cSpinnerColor
        controller?.trackerColor = trackerColor
        controller?.aSpinnerColor = aSpinnerColor
        controller?.bSpinnerColor = bSpinnerColor
        controller?.modalPresentationStyle = .overFullScreen
        controller?.transitioningDelegate = transitionManager
        delegate?.present(controller!, animated: true, completion: nil)
    }
    
    func preloaderSpinnerViewClosed() {
        self.preloaderListener?.preloaderClosed()
        controller?.view.layer.removeFromSuperlayer()
        controller = nil
    }
    
    deinit {
        preloaderListener = nil
        controller?.delegate = nil
        controller = nil
        transitionManager = nil
    }
    
    /// Kapatmak için kullanılır.
    public func close(){
        controller?.close()
    }
    
}
