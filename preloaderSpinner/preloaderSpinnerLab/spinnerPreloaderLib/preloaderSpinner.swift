//
//  preloaderSpinner.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

protocol preloaderSpinnerDelegate:class {
    func preloaderSpinnerViewClosed()
}

/// UIView oluşturucu
class preloaderSpinner: UIViewController {
    
    weak var delegate:preloaderSpinnerDelegate!
    
    private var trackLayer:CAShapeLayer = {
        let cirPath = UIBezierPath(arcCenter: .zero, radius: (80)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let shape = CAShapeLayer()
        shape.path = cirPath.cgPath
        shape.lineCap = kCALineCapRound
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.clear.cgColor
        shape.lineWidth = 8
        return shape
    }()
    
    private var cShapeLayer:CAShapeLayer = {
        let cirPath = UIBezierPath(arcCenter: .zero, radius: (80)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let shape = CAShapeLayer()
        shape.path = cirPath.cgPath
        shape.lineCap = kCALineCapRound
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 6
        shape.strokeEnd = 0
        return shape
    }()
    
    
    private var bShapeLayer:CAShapeLayer = {
        let cirPath = UIBezierPath(arcCenter: .zero, radius: (60)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
        let shape = CAShapeLayer()
        shape.path = cirPath.cgPath
        shape.lineCap = kCALineCapRound
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.green.cgColor
        shape.lineWidth = 6
        shape.strokeEnd = 0
        return shape
    }()
    
    
    private var aShapeLayer:CAShapeLayer = {
        let cirPath = UIBezierPath(arcCenter: .zero, radius: (40)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: false)
        let shape = CAShapeLayer()
        shape.path = cirPath.cgPath
        shape.lineCap = kCALineCapRound
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.blue.cgColor
        shape.lineWidth = 6
        shape.strokeEnd = 0
        return shape
    }()
    
    private var spinnerColorHolder:UIColor = UIColor.red
    var spinnerColor:UIColor{
        set{
            spinnerColorHolder = newValue
        }get{
            return spinnerColorHolder
        }
    }
    
    
    private var trackerColorHolder:UIColor = UIColor.gray
    var trackerColor:UIColor{
        set{
            trackerColorHolder = newValue
        }get{
            return trackerColorHolder
        }
    }
    
    private var backgroundColorHolder:UIColor = UIColor.black.withAlphaComponent(0.4)
    var backgroundColor:UIColor{
        set{
            backgroundColorHolder = newValue
        }get{
            return backgroundColorHolder
        }
    }
    
    private var bSpinnerColorHolder:UIColor = UIColor.green
    /// orta kısımdaki spinner rengi
    var bSpinnerColor:UIColor {
        set{
            bSpinnerColorHolder = newValue
        }get{
            return bSpinnerColorHolder
        }
    }
    
    private var aSpinnerColorHolder:UIColor = UIColor.white
    /// iç kısımdaki spinner rengi
    var aSpinnerColor:UIColor {
        set{
            aSpinnerColorHolder = newValue
        }get{
            return aSpinnerColorHolder
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawPreloader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
    }
    
    /*
    func rotate(angle: CGFloat, _view:UIView) {
        let radians = angle / 180.0 * CGFloat(Double.pi)
        let rotation = _view.transform.rotated(by: radians)
        _view.transform = rotation
    }*/
    
    private func drawPreloader(){
        cShapeLayer.position = self.view.center
        trackLayer.position = self.view.center
        bShapeLayer.position = self.view.center
        aShapeLayer.position = self.view.center
        trackLayer.strokeColor = trackerColor.cgColor
        cShapeLayer.strokeColor = spinnerColor.cgColor
        bShapeLayer.strokeColor = bSpinnerColor.cgColor
        aShapeLayer.strokeColor = aSpinnerColor.cgColor
        
        self.view.layer.addSublayer(trackLayer)
        self.view.layer.addSublayer(cShapeLayer)
        self.view.layer.addSublayer(bShapeLayer)
        self.view.layer.addSublayer(aShapeLayer)
        animationOpen()
    }
    
    func animationOpen(){
        cShapeLayer.removeAllAnimations()
        cShapeLayer.strokeEnd = 0.6

        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.fillMode = kCAFillModeForwards
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        cShapeLayer.add(rotation, forKey: "open")
        
        
        bShapeLayer.strokeEnd = 0.6
        let rotationb : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationb.toValue = -(CGFloat.pi*2)//NSNumber(value: -(Double.pi * 2))
        rotationb.duration = 1
        rotationb.isCumulative = true
        rotationb.fillMode = kCAFillModeForwards
        rotationb.repeatCount = Float.greatestFiniteMagnitude
        rotationb.isRemovedOnCompletion = false
        bShapeLayer.add(rotationb, forKey: "openb")
        
        aShapeLayer.strokeEnd = 0.6
        let rotationa : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationa.toValue = NSNumber(value: Double.pi * 2)
        rotationa.duration = 1
        rotationa.isCumulative = true
        rotationa.fillMode = kCAFillModeForwards
        rotationa.repeatCount = Float.greatestFiniteMagnitude
        rotationa.isRemovedOnCompletion = false
        aShapeLayer.add(rotationa, forKey: "opena")
    }
    
    public func close(){
        self.dismiss(animated: true) {
            if self.delegate != nil {
                self.delegate?.preloaderSpinnerViewClosed()
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cShapeLayer.removeAnimation(forKey: "open")
        bShapeLayer.removeAnimation(forKey: "openb")
        self.view.layer.removeAllAnimations()
        self.view.layer.removeFromSuperlayer()
        cShapeLayer.removeAllAnimations()
        trackLayer.removeAllAnimations()
        cShapeLayer.removeFromSuperlayer()
        trackLayer.removeFromSuperlayer()
    }
    
    /*
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.all
    }*/
    
    override var shouldAutorotate: Bool{
        cShapeLayer.position = self.view.center
        trackLayer.position = self.view.center
        bShapeLayer.position = self.view.center
        aShapeLayer.position = self.view.center
        return true
    }
    
}
