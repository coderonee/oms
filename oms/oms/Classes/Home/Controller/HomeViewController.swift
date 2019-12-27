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
    private var titles = ["推荐","游戏","娱乐","酷玩","音乐"]
    
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView =  PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //确定所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        contentView.delegate = self
        return contentView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:-设置UI界面
        setupUI()

    }
}

//MARK:- 设置UI界面
extension HomeViewController{
    private func setupUI(){
        
        //automaticallyAdjustsScrollViewInsets = false
        
        setUpNavigateionBar()
        
        //设置titleView
        view.addSubview(pageTitleView)
        //设置contenView
        view.addSubview(pageContentView)
        
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

//MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pagaTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndx(index: index)
    }
}

//MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat) {
        pageTitleView.setTitleWithProgress(progress: progress)
    }
}

