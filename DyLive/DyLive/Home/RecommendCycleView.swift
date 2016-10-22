//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by 1 on 16/9/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit


private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]?{
        didSet{
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0)*10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        collectionView.register((UINib(nibName:"CollectionCycleCell", bundle: nil)), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let  layot = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layot.itemSize = collectionView.bounds.size
    }
}

// MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView()->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as!
        RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0)*10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as!  CollectionCycleCell
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        return cell
    }
}


// MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX/scrollView.bounds.width)%(cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}




// MARK:- 对定时器的操作方法
extension RecommendCycleView {
    fileprivate func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    
    fileprivate func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        let currentOfsetX =  collectionView.contentOffset.x
        let offsetX = currentOfsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
    
}
