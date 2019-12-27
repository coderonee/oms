//
//  PageContentView.swift
//  oms
//
//  Created by onee on 2019/12/26.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class  {
    func pageContentView(contentView : PageContentView, progress : CGFloat)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbitScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
       //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UIcollectionView
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        //3.设置数据源
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        //4.设置代理
        collectionView.delegate = self
        
        return collectionView
    }()
    
    init(frame: CGRect, childVcs : [UIViewController] , parentViewController : UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //MARK:-设置UI界面
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- 设置UI界面
extension PageContentView{
    private func setupUI(){
        //1.将所有自控制器添加父控制器中
        for childVc in childVcs {
            parentViewController?.addChild(childVc)
        }
        
        //2.添加uicollectionView，用于cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        //1.避免重复加载
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        //2.给cell设置内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}


//MARK:-遵守UICollectionViewDelegate代理方法
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbitScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.是否是点击事件
        if isForbitScrollDelegate == true {return}
        
        //2.定义滑动比例，正值左滑，负值右滑
        var progress : CGFloat = 0
        let currentOffsetX = scrollView.contentOffset.x
        progress = (currentOffsetX - startOffsetX) / scrollView.bounds.width
        progress = (progress > 1 || progress <  -1) ? 0 : progress
        
        //3.通知代理
        delegate?.pageContentView(contentView: self, progress: progress)
    }
}


//MARK:-对外暴露方法
extension PageContentView{
    func setCurrentIndx(index : Int) {
        isForbitScrollDelegate = true
        
        let offsetX = CGFloat(index) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}



