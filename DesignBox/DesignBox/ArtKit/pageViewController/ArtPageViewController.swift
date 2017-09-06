//
//  ArtPageViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/28.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

protocol ArtPageHeaderViewProtocol {
    //表示变量是可读可写的
    var currentIndex:Int {get set}
    
}



class ArtPageViewController: UIViewController {

    //MARK: - Properties
    var pageDoingScroll: Bool = false
    var isCurrentPage: Bool = false
    var pageHeaderView:ArtPageHeaderViewProtocol?
    var workFilterModel: ArtFilterModel?
    var scrollTab: ArtScrollTab?
    var initialIndex:Int = 0
    
    //MARK: - Functions
    func cleanAll() -> Void {
        if self.pageHeaderView != nil {
            (self.pageHeaderView as! UIView).removeFromSuperview()
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
        cleanAll()
        self.workFilterModel = ArtFilterModel()
        self.workFilterModel?.maxCachedCount = maxCachedCount()
        self.workFilterModel?.categoryList = self.categoryList!
        
        if !customPageHeaderView() {
            self.scrollTab = ArtScrollTab()
            self.scrollTab?.delegate = self
            self.view.addSubview(self.scrollTab!)
            self.scrollTab?.snp.makeConstraints({ (make) in
                make.left.right.top.equalTo(self.view)
                make.height.equalTo((self.scrollTab?.tabHeight())!)
            })
            
            self.scrollTab?.curIndexDidChangeBlock = { (index) -> Void in
                self.scrollTabCurIndexDidChange(aIndex: index)
            }
            
            if let view = scrollTabRightView() {
                self.view.addSubview(view)
                view.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(self.scrollTab!)
                    make.left.equalTo((self.scrollTab?.snp.right)!)
                    make.right.equalTo(self.view.snp.right)
                })
            }
            
            self.scrollTab?.setTabBarItems(items: (self.workFilterModel?.categoryList)!, index: self.initialIndex)
            
            self.pageHeaderView = scrollTab
            
            if !artScrollTabDividerHidden() {
                let sepLine = UIView()
                sepLine.backgroundColor = UIColor.red
                self.view.addSubview(sepLine)
                sepLine.snp.makeConstraints({ (make) in
                    make.left.right.equalTo(self.view)
                    make.bottom.equalTo((self.scrollTab?.snp.bottom)!)
                    make.height.equalTo(1.0/SCREEN_SCALE)
                })
            }
        } else {
            self.pageHeaderView = customHeaderView()
            self.view.addSubview(self.pageHeaderView as! UIView)
            (self.pageHeaderView as! UIView).snp.makeConstraints({ (make) in
                make.top.left.right.equalTo(self.view)
                make.height.equalTo(heightForHeaderView())
            })
        }
        
        self.workFilterModel?.categoryListIndex = self.initialIndex
        self.workFilterModel?.contentVCBlock = {(_ currentIndex:Int) -> (UIViewController) in
            return self.createControllerByIndex(index: currentIndex)!
        }
        
        createPageViewPageIndex(index: self.initialIndex)
        if !pageViewControllerScrollEnabled() {
            self.findScrollView()?.isScrollEnabled = false
        }
    }
    
    
    func scrollTabCurIndexDidChange(aIndex:Int) -> Void {
        let idx = self.workFilterModel?.indexOfPageController(viewController: (self.pageViewController.viewControllers?.first)!)
        if idx != aIndex {
            self.pageDoingScroll = true
            let vc = self.workFilterModel?.pageControllerAtIndex(aIndex: aIndex)
            guard vc != nil else {
                self.pageDoingScroll = false
                return
            }
            
            self.pageViewController.setViewControllers([vc!], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: { (finish) in
                self.pageDoingScroll = false
            })
        } else {
            if !self.isCurrentPage {
                
            } else {
                self.isCurrentPage = false
            }
            
        }
        self.workFilterModel?.categoryListIndex = aIndex

    }
    
    
    func createPageViewPageIndex(index:Int) -> Void {
        self.pageViewController.dataSource = self
        self.addChildViewController(self.pageViewController)
        
        let viewController = self.workFilterModel?.pageControllerAtIndex(aIndex: index)
        guard viewController != nil else {
            return
        }
        
        self.pageViewController.setViewControllers([viewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        self.pageViewController.didMove(toParentViewController: self)
        
        let view = self.pageViewController.view
        self.view.addSubview(view!)
        view?.snp.makeConstraints({ (make) in
            make.top.equalTo(((self.pageHeaderView as! UIView).snp.bottom))
            make.left.right.bottom.equalTo(self.view)
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Lazy Load

    lazy var categoryList:[ArtScrollTabDelegate]? = {
        let namelist = self.categoryNameList()
        if namelist?.count == 0 {
            return nil
        }
        
        var list:[ArtScrollTabDelegate] = [ArtScrollTabDelegate]()
        var index:Int = 0
        for name in namelist! {
            let item = ArtScrollTabItem()
            let cate = ArtUserConfig.shared.reqCategory![index]
            item.tabTitle = name
            item.tabId = cate["_id"] as? String
            list.append(item)
            index+=1
        }
        
        return list
    }()
    
    lazy var pageViewController:UIPageViewController = {
        let options = [UIPageViewControllerOptionSpineLocationKey:UIPageViewControllerSpineLocation.min]
        let tempPageVC = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: options)
        tempPageVC.dataSource = self
        tempPageVC.delegate = self
        return tempPageVC
    }()

}



//MARK: Build View
extension ArtPageViewController {
    func scrollTabRightView() -> UIView? {
        return nil
    }
    
    func artScrollTabDividerHidden() -> Bool {
        return true
    }
    
    func customHeaderView() -> ArtPageHeaderViewProtocol? {
        return nil
    }
    
    func heightForHeaderView() -> CGFloat {
        return 0
    }
    
    func createControllerByIndex(index:Int) -> UIViewController? {
        return nil
    }
}


extension ArtPageViewController {
    //这里面 的信息是需要子类去重写的
    
    func maxCachedCount() -> Int {
        return 3
    }
    
    func customPageHeaderView() -> Bool {
        return false
    }
    
    func pageViewControllerScrollEnabled() -> Bool {
        return true
    }
    
    func categoryNameList() -> [String]? {
        return nil
    }
    

    
}


extension ArtPageViewController: UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let idx = self.workFilterModel?.indexOfPageController(viewController: viewController) {
            return self.workFilterModel?.pageControllerAtIndex(aIndex: idx+1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let idx = self.workFilterModel?.indexOfPageController(viewController: viewController) {
            return self.workFilterModel?.pageControllerAtIndex(aIndex: idx-1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished && !pageDoingScroll {
            isCurrentPage = true
            if let idx = self.workFilterModel?.indexOfPageController(viewController:(pageViewController.viewControllers?.first!)!) {
                self.scrollTab?.currentIndex = idx
            }
            
        }
        
    }
    
    func findScrollView() -> UIScrollView? {
        var scrollView:UIScrollView?
        
        for subview in self.pageViewController.view.subviews {
            
            if subview is UIScrollView {
                scrollView = subview as? UIScrollView
            }
        }
        
        return scrollView
    }
    
}


extension ArtPageViewController: ArtScrollTabDelegate {
    
    func artScrollTabHeight(scrollTab:ArtScrollTab) -> CGFloat {
        return 39
    }
    func artScrollTabIndicatorBottomMargin() -> CGFloat {
        return 3
    }
    func artScrollTabItemShowType(scrollTab:ArtScrollTab) -> Int {
        return 1
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
