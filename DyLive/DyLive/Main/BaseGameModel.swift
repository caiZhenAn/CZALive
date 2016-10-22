//
//  BaseGameModel.swift
//  DyLive
//
//  Created by cza on 16/10/17.
//  Copyright © 2016年 cza. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    var tag_name:String?
    var icon_url:String?
    
    override init(){
        
    }
    
    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
