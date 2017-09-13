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
    var bannerList: ArtBannerList?
    var headlines: [ArtArticleList]?
    
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = UIColor.white
        return tableView;
    }()
    
    
    func scan() -> Void {
        let scanVc = ArtScanViewController()
        scanVc.hidesBottomBarWhenPushed = true
        scanVc.title = "扫一扫"
        self.navigationController?.pushViewController(scanVc, animated: true)
    }
    
    func publish() -> Void {
        let menuVc = ArtPublishMenuViewController()
        menuVc.showInViewController(viewController: self.navigationController!)
    }
    
    func configNavBar() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "custom_scan"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtWorkListViewController.scan))
        
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "pulish"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtWorkListViewController.publish))
    }
    

    
    func buildUI() -> Void {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        registerCells()
        configNavBar()
        
        self.art_addPullToRefresh(tableView: tableView, completion: { 
            self.fetchData()
        })
    }
    
    
    func showPhotoBrowser(work:ArtWork?,index:Int) -> Void {
        let browser = ArtImageBrowserController()
        let viewModel = ArtWorkImageViewModel()
        viewModel.work = work
        browser.curIndex = index-10000
        let model = ArtImageBrowserModel()
        model.imageURL = work?.work?.imgs?[index-10000]["imgurl"] as? String
        browser.fileItem = model
        browser.viewModel = viewModel
        browser.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(browser, animated: true, completion: nil)
    }
    
    //MARK 获取网络数据
    func fetchData() -> Void {
        let worklistCommand = ArtWorkCommand()
        worklistCommand.order = "1"
        
        worklistCommand.fetchWork(success: { (works,bannerList,headlines) in
            //请求获取的work
            if works.count > 0 {
                self.works = works
                self.tableView.reloadData()
            }
            self.bannerList = bannerList
            self.headlines = headlines
        }) { (error) in
            print(error)
        }
    }
    
    
    func registerCells() -> Void {
        tableView.register(ArtWorkCell.self, forCellReuseIdentifier: "ArtWorkCell")
        tableView.register(ArtBannerCell.self, forCellReuseIdentifier: "ArtBannerCell")
        tableView.register(ArtHeadlineCell.self, forCellReuseIdentifier: "ArtHeadlineCell")
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
        
        var number = 0
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) ) {
            number += 1
        }
        
        if ((self.headlines != nil) && ((self.headlines?.count)! > 0) ) {
            number += 1
        }
        
        if let paints = works {
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
        } else if ((self.headlines != nil) && ((self.headlines?.count)! > 0) && indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtHeadlineCell") as! ArtHeadlineCell
            
            cell.scrollView.configHeadLinesCell(lines: self.headlines!)
            return cell
        } else {
            var number = 0
            if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) ) {
                number += 1
            }
            
            if ((self.headlines != nil) && ((self.headlines?.count)! > 0) ) {
                number += 1
            }
            
            let cell:ArtWorkCell = tableView.dequeueReusableCell(withIdentifier: "ArtWorkCell") as! ArtWorkCell
            cell .configWorkCell(work: (works?[indexPath.section-number])!)
            cell.tapBlock = {(_ work:ArtWork?,_ index:Int) -> Void in
                self.showPhotoBrowser(work: work, index: index)
            }
            return cell;
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) && indexPath.section == 0) {
            return ArtBannerCell.bannerHeight()
        } else  if ((self.headlines != nil) && ((self.headlines?.count)! > 0) && indexPath.section == 1) {
            return ArtHeadlineCell.height()
        }
        var number = 0
        if ((self.bannerList != nil) && ((self.bannerList?.banners?.count)! > 0) ) {
            number += 1
        }
        if ((self.headlines != nil) && ((self.headlines?.count)! > 0) ) {
            number += 1
        }
        return ArtWorkCell.cellHeight(work: (works?[indexPath.section-number])!)
    }

}


