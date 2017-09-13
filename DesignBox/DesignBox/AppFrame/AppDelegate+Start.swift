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
    
    
    func setUMeng() -> Void {
        let url:String = "http://www.umeng.com/social"
        // 友盟
        UMSocialManager.default().umSocialAppkey = "55e66807e0f55a41750006c7"
        
        UMSocialManager.default().setPlaform(.wechatSession, appKey: "wx1fc7563d9a774388", appSecret: "1fe70ec90cd099ec3f8c86231727d1b9", redirectURL: url)
        
        UMSocialManager.default().setPlaform(.QQ, appKey: "1104826860", appSecret: "57Pn46hho7jrUFux", redirectURL: url)
        
        UMSocialManager.default().setPlaform(.sina, appKey: "73126032", appSecret: "7ae506aff40c63b6f58c2f7e167b27b7", redirectURL: nil)
    }
    
    //并添加系统回调方法
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result {
            //返回其他
        }
        return result
    }
    
    
    func fetchSorts() -> Void {
        let initCmd = ArtCommandInitInfo()
        initCmd.sorttype = "1"
        initCmd.fetchSort()
    }
    
    public func art_didFinishLaunchingWithOptions(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Void {
        let tabBar = tabBarController?.tabBar
        tabBarController?.delegate = self
        tabBar?.tintColor = UIColor.art_mainColor()
        tabBar?.barTintColor = UIColor.white
        tabBar?.shadowImage = UIColor.art_sepLineHColor().imageForColor()
        tabBar?.backgroundImage = UIColor.white.imageForColor()
        
        let dict = [NSForegroundColorAttributeName:UIColor.black]
        for item in (tabBar?.items)! {
            (item as UITabBarItem).setTitleTextAttributes(dict, for: UIControlState.selected)
        }

        let navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
        navBar.tintColor = UIColor.art_fontColor()
        navBar.barTintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.art_fontColor(),NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
        navBar.setBackgroundImage(UIColor.white.imageForColor(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        navBar.shadowImage = UIColor.art_sepLineHColor().imageForColor()
        setUMeng()
        fetchSorts()
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


