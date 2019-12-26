//
//  HomeViewController.swift
//  oms
//
//  Created by onee on 2019/12/24.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    private lazy var pageTitleView : PageTitleView = {
       let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","酷玩"]
        let titleView =  PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUi()

    }
}

//MARK:- 设置UI界面
extension HomeViewController{
    private func setUpUi(){
        
        //automaticallyAdjustsScrollViewInsets = false
        
        setUpNavigateionBar()
        
        view.addSubview(pageTitleView)
        
    }
    
    
    private func setUpNavigateionBar(){
        /*
        let size = CGSize(width: 20, height: 20)
        
        let btn = UIBarButtonItem.createItem(imageName: "logo")
        navigationItem.leftBarButtonItem = btn
        
        let btn1 = UIBarButtonItem.createItem(imageName: "logo", highImageName: "logo", size: size)
        let btn2 = UIBarButtonItem.createItem(imageName: "logo", highImageName: "logo", size: size)
        let btn3 = UIBarButtonItem.createItem(imageName: "logo", highImageName: "logo", size: size)
        
        navigationItem.rightBarButtonItems = [btn1,btn2,btn3]
        */
        
        
    }
    
    
}

