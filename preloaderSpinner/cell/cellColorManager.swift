//
//  cellColorManager.swift
//  lottoServiceTR
//
//  Created by namik kaya on 1.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import UIKit
class cellColorManager {
    var firstColor = UIColor.init(hex: "#0f487f") // mavi
    var secondColor = UIColor.init(hex: "#00a770") // yeşil
    
    func check(row:Int, mod:Int = 2)->UIColor{
        if row%mod == 0 {
            return firstColor
        }else{
            return secondColor
        }
    }
}
