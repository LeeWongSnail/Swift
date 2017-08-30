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
        tab.delegate = self;
        return tab
    }()

}


extension ArtRequirementViewController: ArtScrollTabDelegate {
    
    func artScrollTabHeight(scrollTab:ArtScrollTab) -> CGFloat {
        return 44
    }
    func artScrollTabIndicatorBottomMargin() -> CGFloat {
        return 3
    }
    func artScrollTabItemShowType(scrollTab:ArtScrollTab) -> Int {
        return EArtScrollTabItemShowType.Automatic.rawValue
    }
    func artScrollTabItemControlLimitWidth(scrollTab:ArtScrollTab) -> CGFloat {
        return 80
    }
    func artScrollTabItemOffset(scrollTab:ArtScrollTab) -> CGFloat {
        return 0
    }
    func artScrollTabItemNormalColor(scrollTab:ArtScrollTab) -> UIColor {
        return UIColor.gray
    }
    func artScrollTabItemSelectedColorColor(scrollTab:ArtScrollTab) -> UIColor {
        return UIColor.red
    }
    func artScrollTabIndicatorViewHidden() -> Bool {
        return false
    }
}
