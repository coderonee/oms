//
//  UIColor-Extension.swift
//  oms
//
//  Created by onee on 2019/12/26.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b : CGFloat){
        self.init(red : r / 255.0, green : g / 255.0, blue: b / 255.0 ,alpha: 1.0)
    }
}
