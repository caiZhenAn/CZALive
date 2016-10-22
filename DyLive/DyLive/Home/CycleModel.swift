//
//  CycleModel.swift
//  DyLive
//
//  Created by cza on 16/10/19.
//  Copyright © 2016年 cza. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var title : String = ""
    var pic_url : String = ""
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    var room : [String : NSObject]?{
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict :[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
