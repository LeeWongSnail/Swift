//
//  ArtPageViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/28.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtPageViewController: UIViewController {

    //MARK: - Properties
    var pageDoingScroll: Bool?
    var isCurrentPage: Bool?
    var pageHeaderView: UIView?
    var workFilterModel: ArtFilterModel?
    var scrollTab: ArtScrollTab?
    
    
    //MARK: - Functions
    func cleanAll() -> Void {
        if self.pageHeaderView != nil {
            self.pageHeaderView!.removeFromSuperview()
            self.pageHeaderView = nil
        }
        
        if self.scrollTab != nil {
            self.scrollTab?.removeFromSuperview()
            self.scrollTab = nil
        }
        self.pageDoingScroll = false
        self.isCurrentPage = false
        self.workFilterModel = nil
        self.pageViewController.view.removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
    }
    
    
    //MARK: - Build View
    func buildMainView() -> Void {
        
//        self.workFilterModel = 
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    lazy var pageViewController:UIPageViewController = {
        let options = [UIPageViewControllerOptionSpineLocationKey:UIPageViewControllerSpineLocation.min]
        let tempPageVC = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: options)

        return tempPageVC
    }()

}



extension ArtPageViewController: ArtScrollTabDelegate {
    
    func artScrollTabHeight(scrollTab:ArtScrollTab) -> CGFloat {
        return 44
    }
    func artScrollTabIndicatorBottomMargin() -> CGFloat {
        return 3
    }
    func artScrollTabItemShowType(scrollTab:ArtScrollTab) -> Int {
        return 0
    }
    func artScrollTabItemControlLimitWidth(scrollTab:ArtScrollTab) -> CGFloat {
        return 80
    }
    func artScrollTabItemOffset(scrollTab:ArtScrollTab) -> CGFloat {
        return 40
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
