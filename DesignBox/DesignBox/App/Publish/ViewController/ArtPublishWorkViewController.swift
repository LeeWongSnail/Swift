//
//  ArtPublishWorkViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtPublishWorkViewController: UIViewController {


    
    //MARK: -CUSTOM METHOD
    func backDidClick() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextStep() -> Void {
        
    }
    
    func registerCells() -> Void {
        tableView.register(UINib.init(nibName: "ArtPublishWorkTextCell", bundle: nil), forCellReuseIdentifier: "ArtPublishWorkTextCell")
        tableView.register(UINib.init(nibName: "ArtPublishWorkControlCell", bundle: nil), forCellReuseIdentifier: "ArtPublishWorkControlCell")
        tableView.register(ArtPublishWorkImageCell.self, forCellReuseIdentifier: "ArtPublishWorkImageCell")
    }
    
    //MARK: - LOAD VIEW
    func configNavItems() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtPublishWorkViewController.backDidClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtPublishWorkViewController.nextStep))
    }
    
    func buildUI() -> Void {
        registerCells()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        configNavItems()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var tableView = { () -> UITableView in 
        let tempTableView = UITableView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.tableFooterView = nil
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tempTableView
    }()

}

extension ArtPublishWorkViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtPublishWorkTextCell") as! ArtPublishWorkTextCell
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtPublishWorkImageCell") as! ArtPublishWorkImageCell
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtPublishWorkControlCell") as! ArtPublishWorkControlCell
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return ArtPublishWorkTextCell.cellHeight()
            
        case 1:
            return 100
        case 2:
            return 48
        default:
            return 0
        }
    }
    
}




