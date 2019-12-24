//
//  HomeViewController.swift
//  oms
//
//  Created by onee on 2019/12/24.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUi()

    }
}

//MARK:- 设置UI界面
extension HomeViewController{
    private func setUpUi(){
        setUpNavigateionBar()
        
    }
    private func setUpNavigateionBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named : ""), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}

