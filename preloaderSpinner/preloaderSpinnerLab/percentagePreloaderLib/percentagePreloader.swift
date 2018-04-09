//
//  percentagePreloader.swift
//  preloaderSpinner
//
//  Created by namik kaya on 9.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import UIKit

protocol percentagePreloaderDelegate:class{
    func percentagePreloaderClose()
}

class percentagePreloader: NSObject, percentageSpinnerDelegate {
    let transitionManager = preloaderSpinnerTransition()
    // bu class için referans
    private weak var percentageListener:percentagePreloaderDelegate?
    
    var controller:percentageSpinner?
    weak var delegate: UIViewController?
    
    private var trackkerColorHolder:UIColor = UIColor.white
    /// Trackker color
    var trackkerColor:UIColor{
        set{
            trackkerColorHolder = newValue
        }get{
            return trackkerColorHolder
        }
    }
    
    private var spinnerColorHolder:UIColor = UIColor.red
    /// spinner Color
    var spinnerColor:UIColor{
        set{
            spinnerColorHolder = newValue
        }get{
            return spinnerColorHolder
        }
    }
    
    private var backgroundColorHolder:UIColor = UIColor.gray.withAlphaComponent(0.7)
    /// background Color
    var backgroundColor:UIColor{
        set{
            backgroundColorHolder = newValue
        }get{
            return backgroundColorHolder
        }
    }
    
    
    private var textColorHolder:UIColor = UIColor.white
    /// percent Text Color
    var textColor:UIColor {
        set{
            textColorHolder = newValue
        }get{
            return textColorHolder
        }
    }
    
    
    override init() {
        super.init()
    }
    
    public func begin() {
        percentageListener = delegate as? percentagePreloaderDelegate
        controller = percentageSpinner()
        controller?.delegate = self
        controller?.backgroundColor = backgroundColor
        controller?.textColor = textColor
        controller?.spinnerColor = spinnerColor
        controller?.trackkerColor = trackkerColor
        controller?.modalPresentationStyle = .overFullScreen
        controller?.transitioningDelegate = transitionManager
        delegate?.present(controller!, animated: true, completion: nil)
    }
    
    private var percentHolder:CGFloat = 0
    var percent:CGFloat = 0.0 {
        didSet{
            controller?.percent = percent
        }
    }
    
    /// Kapatmak için kullanılır.
    public func close(){
        controller?.close()
    }
    
    func percentageSpinnerClosed() {
        self.percentageListener?.percentagePreloaderClose()
        controller?.view.layer.removeFromSuperlayer()
        controller = nil
    }
}
