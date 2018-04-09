//
//  showImageViewController.swift
//  preloaderSpinner
//
//  Created by namik kaya on 9.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

class showImageViewController: UIViewController {
    
    var image:UIImage!
    @IBOutlet weak var showImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = image{
            self.showImage.image = img
            self.showImage.contentMode = UIViewContentMode.scaleAspectFit
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
