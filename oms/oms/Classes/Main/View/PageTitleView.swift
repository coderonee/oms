//
//  PageTitleView.swift
//  oms
//
//  Created by onee on 2019/12/25.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

class PageTitleView: UIView{
    
    //MARK:- 定义属性
    private var titles : [String]
    
    //MARK:- 懒加载属性
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        
        return scrollView
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]){
        self.titles = titles
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageTitleView {
    private func setUpUI(){
        //1.添加scrollView
        addSubview(scrollView)
        
        //2.添加title对应的lable
        setupTitleLables()
    }
    
    private func setupTitleLables(){
        for (index, title) in titles.enumerated(){
            let lable = UILabel()
            
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.darkGray
            lable.textAlignment = .center
            
            let lableW : CGFloat = frame.width / CGFloat(titles.count)
            let lableH : CGFloat = frame.height - 2.0
            let lableX : CGFloat = lableW * CGFloat(index)
            let lableY : CGFloat = 0
            
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            scrollView.addSubview(lable)
        }
    }
}




