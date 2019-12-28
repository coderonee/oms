//
//  RecommandViewController.swift
//  oms
//
//  Created by onee on 2019/12/27.
//  Copyright © 2019 onee. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kItemTallH : CGFloat = kItemW * 4 / 3
private let kHeadH : CGFloat =  50
private let ContentTallCellID = "ContentTallCellID"
private let ContentCellID = "ContentCellID"
private let ContentHeadID = "ContentHeadID"

class RecommandViewController: UIViewController {
    //MARK:-懒加载属性
    private lazy var collectionView : UICollectionView = {
       //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //print(self.view.bounds)
        //2.创建UICollectionView
        let collectionView  = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: ContentCellID)
        collectionView.register(UINib(nibName: "CollectionViewTallCell", bundle: nil), forCellWithReuseIdentifier: ContentTallCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContentHeadID)
        collectionView.backgroundColor = UIColor.white
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置界面
        setupUI()
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}


extension RecommandViewController{
    private func setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK:-遵守数据源协议
extension RecommandViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.定义cell
        var cell : UICollectionViewCell!
        
        //2.取出cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentTallCellID, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentHeadID, for: indexPath)
        
        headView.backgroundColor = UIColor.white
        return headView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemTallH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
    
    
}
