//
//  ArtWorkListViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/15.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class ArtWorkListViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView;
    }()
    
    
    func buildUI() -> Void {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    //MARK 获取网络数据
    func fetchData() -> Void {
        let worklistCommand = ArtWorkCommand()
        worklistCommand.order = "1"
        
        worklistCommand.fetchWork(success: { (works) in
            //请求获取的work
            
        }) { (error) in
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: -UITableViewDelegate
    
    
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}


