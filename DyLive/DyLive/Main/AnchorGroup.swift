//
//  AnchorGroup.swift
//  DyLive
//
//  Created by cza on 16/10/17.
//  Copyright © 2016年 cza. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {

     /// 组显示的图标
    var icon_name:String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    var room_list:[[String:NSObject]]?{
        didSet{
            guard let room_list = room_list else {
                return
            }
            for dict in room_list{
                anchors.append(AnchorModel(dict:dict))
            }
            
        }
        
    }
    
}
