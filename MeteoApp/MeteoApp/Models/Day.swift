//
//  Day.swift
//  MeteoApp
//
//  Created by Gaia Magnani on 08/09/2017.
//  Copyright © 2017 Gaia Magnani. All rights reserved.
//

import UIKit

class Day: NSObject {
    
    var longDay: String?
    var max: String?
    var min: String?
    var image: UIImage?
    
    override init() {
        super.init()
    }

    /**
     ### Overview
     Initialize the object carta for Unit test:
     */
    init(longDay: String?,
         max: String?,
         min: String?,
         image: UIImage
        ){
        super.init()
        
        self.longDay = longDay
        self.max = max
        self.min = min
        self.image = image

    }
}
