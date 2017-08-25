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

    var works:[ArtWork]?
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView;
    }()
    
    
    func buildUI() -> Void {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        registerCells()
    }
    
    
    //MARK 获取网络数据
    func fetchData() -> Void {
        let worklistCommand = ArtWorkCommand()
        worklistCommand.order = "1"
        
        worklistCommand.fetchWork(success: { (works) in
            //请求获取的work
            if works.count > 0 {
                self.works = works
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    func registerCells() -> Void {
        tableView.register(ArtWorkCell.self, forCellReuseIdentifier: "ArtWorkCell")
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    
    //MARK: -UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let paints = works {
            return paints.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ArtWorkCell = tableView.dequeueReusableCell(withIdentifier: "ArtWorkCell") as! ArtWorkCell
        cell .configWorkCell(work: (works?[indexPath.section])!)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArtWorkCell.cellHeight(work: (works?[indexPath.section])!)
    }

}


