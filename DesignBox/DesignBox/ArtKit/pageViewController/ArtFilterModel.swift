//
//  ArtFilterModel.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/28.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtFilterModel: NSObject {
    
    var pageControllers: [String:AnyObject]?
    var maxCachedCount: Int?
    var categoryListIndex: Int?
    
    var categoryList = Array<ArtScrollTabDelegate>()
    
    var contentVCBlock: ((_ currentIndex:Int) -> (UIViewController))?
    
    
  
    func removeAndReleaseContentVCFromPagerViewController(aInfoID:String) -> Void {
        let contentVC = self.pageControllers?[aInfoID];
        if (contentVC != nil) {
            self.pageControllers?.removeValue(forKey: aInfoID)
        }
    }
    
    func removeMoreCachedViewController(aIndex:Int) -> Void {
        let totalCount = self.categoryList.count
        let maxCacheCount = self.maxCachedCount
        
        for index in 0...self.categoryList.count-1 {
            if (aIndex - maxCacheCount! > 0) && (index < aIndex-maxCacheCount!) {
                let obj = self.categoryList[index] as! ArtScrollTabItem
                self.removeAndReleaseContentVCFromPagerViewController(aInfoID: obj.tabId!)
            }
            
            if (aIndex + maxCacheCount! < totalCount) && (index > aIndex + maxCacheCount!) {
                let obj = self.categoryList[index] as! ArtScrollTabItem
                self.removeAndReleaseContentVCFromPagerViewController(aInfoID: obj.tabId!)
            }
        }
    }
    
    
    func pageControllerAtIndex(aIndex:Int) -> UIViewController? {
        
        if aIndex == -1 || aIndex >= self.categoryList.count {
            return nil
        }
        self.removeMoreCachedViewController(aIndex: aIndex)
        
        let categroy = self.categoryList[aIndex] as! ArtScrollTabItem
        var viewController = self.pageControllers?[categroy.tabId!]
        
        if viewController == nil {
            if let contentBlock = contentVCBlock {
                viewController = contentBlock(aIndex)
            } else {
                viewController = UIViewController()
            }
        }
        
        self.pageControllers?[categroy.tabId!] = viewController
    
        return viewController as? UIViewController
        
    }
    
    
}
