//
//  UIBarButtonItem-Extension.swift
//  oms
//
//  Created by onee on 2019/12/25.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func createItem(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        return UIBarButtonItem(customView: btn)
    }
    
    convenience init(imageName : String, highImageName : String , size : CGSize){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        self.init(customView : btn)
    }
}
