//
//  SettingUserHeaderView.swift
//  DyLive
//
//  Created by cza on 16/10/16.
//  Copyright © 2016年 cza. All rights reserved.
//

import UIKit

class SettingUserHeaderView: UIView {
    fileprivate lazy var bgImageView:UIImageView = {[weak self] in
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 200))
        imageView.image = UIImage(named: "hehe")
        return imageView
        }()
    
    fileprivate lazy var headerImageView:UIImageView = {[weak self] in
        let imageView = UIImageView(frame: CGRect(x: kScreenW/2-100/2, y: 50, width: 100, height: 100))
        imageView.image = UIImage(named: "home_header_normal")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate lazy var nameLabel :UILabel = {[weak self] in
        let label = UILabel(frame: CGRect(x: kScreenW/2-100/2, y:100+50+5, width: 100, height: 20))
        label.text = "安哥拉"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(headerImageView)
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
