//
//  ProfileViewController.swift
//  DyLive
//
//  Created by cza on 16/10/15.
//  Copyright © 2016年 cza. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    fileprivate lazy var settingView:SettingView = {[weak self] in
        let settingView = SettingView(frame:  CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kScreenH-kStatusBarH - kNavigationBarH-kTabbarH))
        return settingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(settingView)
    }
}
