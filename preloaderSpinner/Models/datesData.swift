//
//  datesData.swift
//  preloaderSpinner
//
//  Created by namik kaya on 9.04.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation

import UIKit

struct dateData:Decodable{
    var tarih:String?
    var tarihView:String?
}

struct allDatesData:Decodable{
    var data:[dateData]?
}
