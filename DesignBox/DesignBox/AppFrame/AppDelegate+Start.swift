//
//  AppDelegate+Start.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/23.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    
    
    public func art_didFinishLaunchingWithOptions(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Void {
        let tabBar = tabBarController?.tabBar
        tabBar?.tintColor = UIColor.art_colorWithHexString(hexString: "F64E4E")
        tabBar?.barTintColor = UIColor.clear
        
        
        let navBar = UINavigationBar.appearance()
        navBar.tintColor = UIColor.art_mainHighColor()
        navBar.barTintColor = UIColor.art_mainGrayColor()
    }
    
}
