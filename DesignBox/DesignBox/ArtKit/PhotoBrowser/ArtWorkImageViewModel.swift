//
//  ArtWorkImageViewModel.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/5.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtWorkImageViewModel: NSObject {

    var contentVCBlock:((Int) -> UIViewController)?
    var pageControllers: [String:AnyObject] = [String:AnyObject]()
    var work:ArtWork?
    var fileItems:[ArtFileItemProtocol] = [ArtFileItemProtocol]()
    
    
    
}

extension ArtWorkImageViewModel:ArtImageBrowserProtocol {

    func setContentViewController(contentVCBlock: @escaping (Int) -> UIViewController) {
        self.contentVCBlock = contentVCBlock
    }
    
    func indexOfPageController(viewController:UIViewController) -> Int {
        var categoryID:String?
        
        for (key,value) in self.pageControllers {
            if (value as! UIViewController) == viewController {
                categoryID = key
            }
        }
        
        var index:Int = 0
        for idx in 0...self.fileItems.count-1 {
            let obj = self.fileItems[idx] 
            if obj.getImageURL!() == categoryID {
                index = idx
            }
        }
        
        return index
    }
    
    
    func pageControllerAtIndex(index: Int) -> UIViewController? {
        if index == -1 || index >= self.fileItems.count {
            return nil
        }
        
        
        let item = self.fileItems[index]
        var viewController = self.pageControllers[item.getImageURL!()!]
        
        if viewController == nil {
            if let contentBlock = contentVCBlock {
                viewController = contentBlock(index)
            } else {
                viewController = UIViewController()
            }
        }
        
        self.pageControllers[item.getImageURL!()!] = viewController
        
        return viewController as? UIViewController
    }
    
    func fileItemAtIndex(index: Int) -> ArtFileItemProtocol? {
        guard index < self.fileItems.count else {
            return nil
        }
        return self.fileItems[index]
    }
    
    func indexOfFile(item: ArtFileItemProtocol) -> Int {
        var index = 0
        for item1 in self.fileItems {
            if item1.getImageURL!() == item.getImageURL!() {
                return index
            }
            
            index += 1
        }
        
        return index
    }
    
    func loadFileItemsCompletion(completion: ([ArtFileItemProtocol], Bool) -> Void) {
        
        guard (work?.work?.imgs?.count)! > 0 else {
            return
        }
        
        var imageItems:[ArtFileItemProtocol] = [ArtFileItemProtocol]()
        for img in (work?.work?.imgs)! {
            //
            let model = ArtImageBrowserModel()
            model.imageURL = img["imgurl"] as? String
            imageItems.append(model)
            
        }
        self.fileItems = imageItems
        completion(imageItems,true)
    }
    
}
