//
//  AppDelegate+Start.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/23.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate:UITabBarControllerDelegate {
    
    
    public func art_didFinishLaunchingWithOptions(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Void {
        let tabBar = tabBarController?.tabBar
        tabBarController?.delegate = self
        tabBar?.tintColor = UIColor.art_colorWithHexString(hexString: "F64E4E")
        tabBar?.barTintColor = UIColor.clear
        
        
        let navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
        navBar.tintColor = UIColor.art_mainHighColor()
        navBar.barTintColor = UIColor.art_mainGrayColor()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let idx = tabBarController.viewControllers?.index(of: viewController) {
            if idx == 4 {
                //判断是否登录
                if !ArtUserConfig.shared.isLogin {
                    let sb = UIStoryboard(name: "ArtLoginViewController", bundle: nil)
                    let login = sb.instantiateInitialViewController()
                    let nav = viewController as! UINavigationController
                    nav.present(login!, animated: true, completion: nil)
                    return false
                }
            }
        }
        return true
    }
    
    
}


