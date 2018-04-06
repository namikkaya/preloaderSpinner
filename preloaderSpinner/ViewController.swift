//
//  ViewController.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, preloaderSpinnerDelegate {
    let transitionManager = preloaderSpinnerTransition()
    
    @IBAction func popUP(_ sender: Any) {
        let controller = preloaderSpinner()
        controller.delegate = self
        controller.modalPresentationStyle = .overFullScreen
        controller.transitioningDelegate = transitionManager
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // preloaderSpinner Delegate
    func preloaderSpinnerClose() {
        print("spinner çalıştı")
    }


}

