//
//  basicCell.swift
//  lottoServiceTR
//
//  Created by namik kaya on 1.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

class basicCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 10
        colorView.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
