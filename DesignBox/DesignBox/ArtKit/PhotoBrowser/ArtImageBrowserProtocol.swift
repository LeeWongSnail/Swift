//
//  ArtImageBrowserProtocol.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/5.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation

//#pragma mark - Page Controller
//- (void)setContentViewController:(UIViewController *(^)(NSInteger currentIndex))aContentVCBlock;
//- (UIViewController *)pageControllerAtIndex:(NSInteger)aIndex;
//- (NSInteger)indexOfPageController:(UIViewController *)aViewController;
//
//#pragma mark - Data
//- (id <ArtFileItemProtocol> )fileItemAtIndex:(NSInteger)aIndex;
//- (NSInteger)indexOfFile:(id)aFileItem;
//- (void)loadFileItemsCompletion:(void (^) (NSArray *fileItems,BOOL succ))aCompletion;


@objc protocol ArtFileItemProtocol {
    @objc optional func getImageURL() -> String?
}


@objc protocol ArtImageBrowserProtocol {
    
    @objc optional func setContentViewController(contentVCBlock:(_ currentIndex:Int) -> UIViewController) -> Void
    @objc optional func pageControllerAtIndex(index:Int) -> UIViewController?
    @objc optional func indexOfPageController(viewController:UIViewController) -> Int
    
    @objc optional func fileItemAtIndex(index:Int) -> ArtFileItemProtocol?
    @objc optional func indexOfFile(item:ArtFileItemProtocol) -> Int
    @objc optional func loadFileItemsCompletion(completion:(_ item:[ArtFileItemProtocol],_ succ:Bool) -> Void) -> Void
}
