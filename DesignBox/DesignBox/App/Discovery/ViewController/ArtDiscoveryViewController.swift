//
//  ArtDiscoveryViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/9.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtDiscoveryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.tableFooterView = nil
        self.tableView.backgroundColor = UIColor.art_colorWithHexString(hexString: "f2f2f2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


extension ArtDiscoveryViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.000001
    }
}
