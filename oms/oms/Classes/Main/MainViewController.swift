//
//  MainViewController.swift
//  oms
//
//  Created by onee on 2019/12/24.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    private func addChildVc(_ storyName : String){
        let vc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!

        addChild(vc)
    }
    


}
