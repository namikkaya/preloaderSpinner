//
//  preloaderSpinner.swift
//  preloaderSpinner
//
//  Created by namik kaya on 6.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

protocol preloaderSpinnerDelegate: class {
    func preloaderSpinnerClose()
}

class preloaderSpinner: UIViewController {
    weak var delegate:preloaderSpinnerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)

        let text:UILabel = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
        text.text = "naber ben namık"
        text.textColor = UIColor.white
        self.view.addSubview(text)
        
        let but:UIButton = UIButton(type: UIButtonType.system);
        but.frame = CGRect(x: 40, y: 60, width: 200, height: 200)
        but.setTitle("geri", for: .normal)
        self.view.addSubview(but)
        but.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
    }
    
    @objc func pressButton(_ sender: UIButton){
        if (self.delegate != nil){
            self.delegate?.preloaderSpinnerClose()
        }
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
