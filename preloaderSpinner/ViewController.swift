//
//  ViewController.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, preloaderDelegate {
    var pre:preloader!
    
    /// Preloader kapatıldığı an cevap döner.
    func preloaderClosed() {
        preloaderClose()
        pre = nil
    }
    
    func preloaderClose() {
        let sVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! secondViewController
        self.present(sVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func popUP(_ sender: Any) {
        
        // test timer. Webservice result data
        _ = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
        
        
        pre = preloader()
        pre.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        pre.trackerColor = UIColor.clear
        pre.cSpinnerColor = UIColor.red
        pre.aSpinnerColor = UIColor.blue
        pre.bSpinnerColor = UIColor.yellow
        pre.delegate = self
        pre.begin()
    }
    
    @objc func update() {
        pre.close()
    }


}

