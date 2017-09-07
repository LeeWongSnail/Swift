//
//  ArtRequirementListController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtRequirementListController: UIViewController {

    var requirements: [ArtRequirementList]?
    var bannerList: ArtBannerList?
    var sortid: String?
    
    
    func fetchRequrement() -> Void {
        let cmd = ArtCommandRequirementList()
        cmd.count = "20"
        cmd.vcount = "0"
        cmd.sortid = sortid
        
        cmd.fetchRequirement(success: { (requirements, bannerList) in
            self.requirements = requirements
            self.bannerList = bannerList
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
    
    
    func buildUI() -> Void {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        registerCells()
    }
    
    func registerCells() -> Void {
//        tableView.register(ArtRequirementCell.self, forCellReuseIdentifier: "ArtRequirementCell")
        tableView.register(UINib.init(nibName: "ArtRequirementCell", bundle: nil), forCellReuseIdentifier: "ArtRequirementCell")
        tableView.register(ArtBannerCell.self, forCellReuseIdentifier: "ArtBannerCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fetchRequrement()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView;
    }()

}


extension ArtRequirementListController: UITableViewDelegate,UITableViewDataSource {
    //MARK: -UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    
    //MARK: -UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var number = 0
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) ) {
            number += 1
        }
        
        if let paints = requirements {
            return paints.count + number
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) && indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtBannerCell") as! ArtBannerCell
            cell.configBannerCell(bannerList: self.bannerList!)
            return cell
        } else {
            var number = 0
            if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) ) {
                number += 1
            }
            let cell:ArtRequirementCell = tableView.dequeueReusableCell(withIdentifier: "ArtRequirementCell") as! ArtRequirementCell
           cell.configRequirementCell(requrement: (requirements?[indexPath.section-number])!)
            return cell;
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) && indexPath.section == 0) {
            return ArtBannerCell.bannerHeight()
        }
        var number = 0
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) ) {
            number += 1
        }
        return ArtRequirementCell.cellHeight(work: (requirements?[indexPath.section-number])!)
    }
}

