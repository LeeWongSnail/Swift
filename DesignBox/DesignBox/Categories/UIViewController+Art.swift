//
//  UIViewController+Art.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/29.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    
    func art_addRefresh(tableView:UITableView) -> DGElasticPullToRefreshLoadingView {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.art_mainColor()

        tableView.dg_setPullToRefreshFillColor(UIColor.green)
        tableView.dg_setPullToRefreshBackgroundColor(UIColor.blue)
        return loadingView
    }
    
    public func art_addPullToRefresh(tableView:UITableView,completion:(()->Void)?) -> Void {
        
        
        tableView.dg_addPullToRefreshWithActionHandler({ 
            if completion != nil {
                completion!()
            }
            
            tableView.dg_stopLoading()
        }, loadingView: art_addRefresh(tableView: tableView))
        
    }
    
    
    func setPullProgress(progress:CGFloat) -> Void {
        
    }
    
    
    func test() -> Void {

    }
    
    func showText(text:String) -> Void {
        let size = CGSize(width: 60, height: 60)
        
        startAnimating(size, message: text, type: NVActivityIndicatorType.ballTrianglePath)
        
       NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.clear
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating()
        }
    }


}
