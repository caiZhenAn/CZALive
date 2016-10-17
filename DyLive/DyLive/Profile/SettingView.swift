//
//  SettingView.swift
//  DyLive
//
//  Created by cza on 16/10/16.
//  Copyright © 2016年 cza. All rights reserved.
//
import UIKit

private let kSettingUserHeadCellID = "kCycleCellID"
private let kCellID = "kCellID"
let imageHeigt:CGFloat = 300.0


class SettingView: UIView {
    
    
    let name_links_tuples : [(String,String)] =
        [
            ("me_setting","记账设置"),
            ("me_problem","意见反馈"),
            ("me_about","关于我们"),
        ]
    
    
    
    fileprivate lazy var headerView:SettingUserHeaderView = {[weak self] in
        let headerView = SettingUserHeaderView(frame: CGRect(x:0, y: 0, width: kScreenW, height: 200))
        return headerView
    }()
    
    
    fileprivate lazy var tableView:UITableView = {[weak self] in
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-64-44), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UINib(nibName: "SettingUserHeadCell", bundle: nil), forCellReuseIdentifier: kSettingUserHeadCellID)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellID)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(tableView)
        tableView.tableHeaderView =  headerView

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: kSettingUserHeadCellID, for: indexPath)
//        let cell  = tableView.dequeueReusableCell(withIdentifier: kCellID, for: indexPath)
        let cell =  UITableViewCell(style:.subtitle, reuseIdentifier: kCellID);
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = name_links_tuples[indexPath.row].1
        cell.imageView?.image = UIImage(named: name_links_tuples[indexPath.row].0)
        
        return cell

    }
}

extension SettingView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y;
        if offsetY < 0 {
            headerView.frame = CGRect(x: offsetY, y: offsetY, width: scrollView.bounds.size.width - offsetY * 2, height: headerView.frame.height - offsetY)
        } else {
            headerView.frame = CGRect(x: 0, y: 0, width:  scrollView.bounds.size.width, height: headerView.frame.height)
        }
        
    }

    
}
