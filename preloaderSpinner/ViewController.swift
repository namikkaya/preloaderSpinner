//
//  ViewController.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, preloaderDelegate {
    func preloaderClose() {
        print("pencere kapandı")
    }
    
    func preloaderOpen() {
        print("pencere açıldı")
    }
    
    
    var pre:preloader!
    @IBAction func popUP(_ sender: Any) {
        pre = preloader()
        pre.delegate = self
        pre.begin()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }


}

