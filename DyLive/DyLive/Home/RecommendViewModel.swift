//
//  RecommendViewModel.swift
//  DyLive
//
//  Created by cza on 16/10/19.
//  Copyright © 2016年 cza. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    // MARK:- 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup :  AnchorGroup = AnchorGroup()
}

extension RecommendViewModel{
    func requestData(_ finishCallback : @escaping ()->()){
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        let dGroup = DispatchGroup()
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String:NSObject] else {
                return
            }
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{
                return
            }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict);
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        // 4.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data该key,获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.遍历字典,并且转成模型对象
            // 3.1.设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            // 3.3.离开组
            dGroup.leave()
        }
        
        // 5.请求2-12部分游戏数据
        dGroup.enter()
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
             dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main  ) {
           self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    func requestCycleData(_ finishCallback:@escaping ()->()){
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
    
}
