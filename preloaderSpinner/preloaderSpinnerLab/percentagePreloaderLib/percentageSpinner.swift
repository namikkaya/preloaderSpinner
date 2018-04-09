//
//  percentageSpinner.swift
//  preloaderSpinner
//
//  Created by namik kaya on 9.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

protocol percentageSpinnerDelegate:class {
    func percentageSpinnerClosed()
}

class percentageSpinner: UIViewController {
    weak var delegate:percentageSpinnerDelegate?
    
    
    //--
    
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
    
    //--
    
    private var percentText:UILabel = {
        let label = UILabel()
        label.text = "% 00"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var trackLayer:CAShapeLayer = {
        let cirPath = UIBezierPath(arcCenter: .zero, radius: (80)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let shape = CAShapeLayer()
        shape.path = cirPath.cgPath
        shape.lineCap = kCALineCapRound
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 14
        return shape
    }()
    
    private var cShapeLayer:CAShapeLayer = {
        let cirPath = UIBezierPath(arcCenter: .zero, radius: (80)/2, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        let shape = CAShapeLayer()
        shape.path = cirPath.cgPath
        shape.lineCap = kCALineCapRound
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 10
        shape.strokeEnd = 0
        shape.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        return shape
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawPreloader()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColor
        percentText.textColor = textColor
        cShapeLayer.strokeColor = spinnerColor.cgColor
        trackLayer.strokeColor = trackkerColor.cgColor
    }
    
    private func drawPreloader(){
        cShapeLayer.position = self.view.center
        trackLayer.position = self.view.center
        
        self.view.addSubview(percentText)
        percentText.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentText.center = self.view.center
        
        self.view.layer.addSublayer(trackLayer)
        self.view.layer.addSublayer(cShapeLayer)
    }
    
    
    var percent:CGFloat = 0 {
        didSet{
            self.percentText.text = "% \(Int(self.percent*100))"
            self.cShapeLayer.strokeEnd = self.percent
        }
    }
    
    public func close(){
        self.dismiss(animated: true) {
            if self.delegate != nil {
                self.delegate?.percentageSpinnerClosed()
            }
            
        }
    }
    
    override var shouldAutorotate: Bool{
        cShapeLayer.position = self.view.center
        trackLayer.position = self.view.center
        percentText.center = self.view.center
        return true
    }
}
