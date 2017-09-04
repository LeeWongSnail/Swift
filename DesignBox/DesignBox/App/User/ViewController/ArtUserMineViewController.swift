//
//  ArtUserMineViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/4.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtUserMineViewController: UITableViewController {

    var  numberInfo:[String:Any]?
    
    
    
    //MARK: - Fetch Userinfo
    
    func fetchUserInfo() -> Void {
        ArtUserService.shared.fetchLoginUserInfo { (cmd, error) in
            
            guard error == nil else {
                print(error!)
                return
            }
            
            self.numberInfo = cmd?.numberInfo
            self.tableView.reloadData()
        }
    }
    
    
    func registerCell() -> Void {
        self.tableView.register(ArtMineCell.self, forCellReuseIdentifier: "ArtMineCell")
        self.tableView.register(ArtUserHeaderCell.self, forCellReuseIdentifier: "ArtUserHeaderCell")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUserInfo()
//        registerCell()
        self.tableView.tableFooterView = nil
        self.tableView.backgroundColor = UIColor.art_colorWithHexString(hexString: "f2f2f2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ArtUserMineViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ArtUserHeaderCell") as! ArtUserHeaderCell
//            
//            return cell
//        }
//        
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtMineCell") as! ArtMineCell
//        
//        if let view = cell.viewWithTag(10000) {
//            
//            let title = (view as! UILabel).text
//            
//            guard title != nil else {
//                return cell
//            }
//            
//            
//            let countLabel = cell.viewWithTag(10001) as! UILabel
//            
//            switch title! {
//            case "我的帖子":
//                countLabel.text = self.numberInfo?["myWorkCount"] as? String
//                break
//            case "我的云收藏":
//                countLabel.text = self.numberInfo?["myCollectionCount"] as? String
//                break
//            case "消息通知":
//                countLabel.text = self.numberInfo?["myFollowCount"] as? String
//                break
//            case "通讯录":
//                countLabel.text = self.numberInfo?["myFansCount"] as? String
//                break
//            case "我的聊天":
//                countLabel.text = self.numberInfo?["myMessageCount"] as? String
//                break
//            case "我发的需求":
//                countLabel.text = self.numberInfo?["myReleaseCount"] as? String
//                break
//            case "我接的需求":
//                countLabel.text = self.numberInfo?["myAcceptCount"] as? String
//                break
//            default:
//                break
//            }
//            
//            
//        }
//        
//        
//        return cell
//    }
}
