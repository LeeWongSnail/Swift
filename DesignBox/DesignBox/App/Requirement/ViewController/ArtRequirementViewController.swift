//
//  ArtRequirementViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/25.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtRequirementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.addSubview(self.scrollTab)
        self.scrollTab.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(44)
        }
//        self.view.layoutIfNeeded()
        initTabItems()
        self.scrollTab.setTabBarItems(items: tabItems)

        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    var tabItems = Array<ArtScrollTabDelegate>()
    func initTabItems() -> Void {
        for index in 0...8 {
            let item = ArtScrollTabItem()
            item.tabId = "\(index)"
            item.tabTitle = "标题".appending(item.tabId!)
            tabItems.append(item)
        }
    }
    
    
    
    lazy var scrollTab:ArtScrollTab = {
        let tab = ArtScrollTab()
        
        return tab
    }()
    
    
    

}
