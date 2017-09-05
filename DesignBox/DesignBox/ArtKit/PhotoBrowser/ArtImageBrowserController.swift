//
//  ArtImageBrowserController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/5.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtImageBrowserController: UIViewController {

    var viewModel: ArtImageBrowserProtocol?
    var fileItem: ArtFileItemProtocol?
    var curIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buildMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    lazy var pageViewController = { () -> UIPageViewController in
        let tempVc = UIPageViewController()
        tempVc.delegate = self
        tempVc.dataSource = self
        return tempVc
    }()

}


extension ArtImageBrowserController:UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return UIViewController()
    }
    
}


extension ArtImageBrowserController {
    
    func buildMainView() -> Void {
        self.viewModel?.setContentViewController!(contentVCBlock: { (index) -> UIViewController in
            return createControllerByIndex(index: index)
        })
        
        self.viewModel?.loadFileItemsCompletion!(completion: { (items, succ) in
            if succ && items.count > 0 {
                let index = self.viewModel?.indexOfFile!(item: self.fileItem!)
                self.createPageViewPageIndex(index: index!)
                self.curIndex = index!
            }
        })
    }
    
    func createControllerByIndex(index:Int) -> UIViewController {
        
        let item = self.viewModel?.fileItemAtIndex!(index: index)
        let singleVc = ArtSingleImageController()
        
        singleVc.imageURL = item?.getImageURL!()
        return singleVc
    }
    
    func createPageViewPageIndex(index:Int) -> Void {
        
        self.addChildViewController(self.pageViewController)
        
        self.pageViewController.setViewControllers([(self.viewModel?.pageControllerAtIndex!(index: index))!], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.pageViewController.didMove(toParentViewController: self)
        
        let view = self.pageViewController.view
        self.view.addSubview(view!)
        view?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        
    }
    
    
    
    
}
