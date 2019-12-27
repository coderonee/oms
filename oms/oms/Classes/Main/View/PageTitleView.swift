//
//  PageTitleView.swift
//  oms
//
//  Created by onee on 2019/12/25.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit


//MARK:-设置点击事件的代理
protocol PageTitleViewDelegate : class {
    func pagaTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

//MARK:- 定义常量
let kScrollLineH : CGFloat = 2.0
let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


//MARK:- 定义PageTitleView类
class PageTitleView: UIView{
    
    //MARK:- 定义属性
    private var titles : [String]
    private var currentIndex : Int = 0
    private var targetIndex  : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK:- 懒加载属性
    private lazy var titleLables : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]){
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageTitleView {
    private func setupUI(){
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的lable
        setupTitleLables()
        
        //3.添加底线和滑块
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLables(){
        //设置frame属性
        let lableW : CGFloat = frame.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.height - kScrollLineH
        let lableY : CGFloat = 0
        
        for (index, title) in titles.enumerated(){
            //创建UILable
            let lable = UILabel()
            
            //设置Lable属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            
            //设置Lable的frame
            let lableX : CGFloat = lableW * CGFloat(index)
            
            lable.frame = CGRect(x: lableX, y: lableY, width: lableW, height: lableH)
            
            //将lable添加到数组
            titleLables.append(lable)
            
            //将Lable添加到scrollView中
            scrollView.addSubview(lable)
            
            //给Lable添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(tapGes:)))
            lable.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        //获取第一个lable
        guard let firstLable = titleLables.first else { return }
        firstLable.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLine.frame = CGRect(x: firstLable.frame.origin.x, y: frame.height - kScrollLineH, width: firstLable.frame.width, height: kScrollLineH)
        
        //scrollView.addSubview(scrollLine)
        addSubview(scrollLine)
        
    }
    
    
}

//MARK:-监听Lable的点击
extension PageTitleView {
    @objc private func titleLableClick(tapGes : UITapGestureRecognizer){
        //获取当前lable的下标
        guard let currentLable = tapGes.view as? UILabel else {return}
        
        //获取之前的lable
        let oldLable = titleLables[currentIndex]
        
        //切换颜色
        currentLable.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //设置currentIndex
        currentIndex = currentLable.tag
        
        //滚动条位置改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15){
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pagaTitleView(titleView: self, selectedIndex: currentIndex)
        
        
    }
}


//MARK:- 对外暴露方法 移动下划线和变换字体颜色
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat){
        
        //1.计算开始lable和目标lable
        if progress > 0 && progress < 1 {
            targetIndex = currentIndex + 1
        } else if progress < 0 && progress > -1 {
            targetIndex = currentIndex - 1
        } else {
            currentIndex = currentIndex + Int(progress)
            targetIndex = currentIndex
        }
        
        if(currentIndex > titles.count - 1){
            currentIndex = titles.count - 1
        }else if(currentIndex < 0){
            currentIndex = 0
        }
        
        if (targetIndex > titles.count - 1) {
            targetIndex = titles.count - 1
        } else if (targetIndex < 0) {
            targetIndex = 0
        }
        
        let absProgress = abs(progress)

        //2.移动scrollLine的位置
        let sourceLable = titleLables[currentIndex]
        let targetLable = titleLables[targetIndex]
        let moveTotalX = (targetLable.frame.origin.x - sourceLable.frame.origin.x) * absProgress
        scrollLine.frame.origin.x = sourceLable.frame.origin.x + moveTotalX

        
        //3.渐变字体颜色
        //3.1.取字体变化范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        
        //3.2.变化sourceLable字体颜色
        sourceLable.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * absProgress, g: kSelectedColor.1 - colorDelta.1 * absProgress, b: kSelectedColor.2 - colorDelta.2 * absProgress)
        
        //3.3.变化targetLable字体颜色
        targetLable.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * absProgress, g: kNormalColor.1 + colorDelta.1 * absProgress, b: kNormalColor.2 + colorDelta.2 * absProgress)
    }
}
