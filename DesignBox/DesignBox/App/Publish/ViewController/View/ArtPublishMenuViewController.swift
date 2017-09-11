//
//  ArtPublishMenuViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtPublishMenuViewController: UIViewController {

    
    var rootNaviController:UINavigationController?
    var topAlphaView: UIView?
    var menuView: ArtPublishChoiceView?
    
    //MARK: - ADD TAP Gesture
    
    func dismissMenu() -> Void {
        dismissMenuAnimated(animated: true)
    }
    
    func dismissMenuAnimated(animated:Bool) -> Void {
        
        if animated {
            
            UIView.animate(withDuration: 0.2, animations: { 
                self.menuView?.center = CGPoint(x: self.view.frame.size.width/2, y: -((self.menuView?.frame.size.height)!/2))
                self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
            }, completion: { (finish) in
                self.view.removeFromSuperview()
                self.removeTopAlphaView()
            })
            
        } else {
            self.view.removeFromSuperview()
            removeTopAlphaView()
        }
        
    }
    
    func showInViewController(viewController:UIViewController) -> Void {
        
        if viewController.isKind(of: UITabBarController.self) {
            self.rootNaviController = (viewController as! UITabBarController).selectedViewController as? UINavigationController
        } else if (viewController.isKind(of: UINavigationController.self)) {
            self.rootNaviController = viewController as? UINavigationController
        } else {
            self.rootNaviController = viewController.navigationController
        }
        
        AppDelegate.getRootWindow()?.addSubview(self.view)
        self.rootNaviController?.addChildViewController(self)
        self.view.snp.makeConstraints { (make) in
            make.edges.equalTo(AppDelegate.getRootWindow()!)
        }
        
        self.rootNaviController?.topViewController?.navigationItem.rightBarButtonItem?.title = nil
        self.rootNaviController?.topViewController?.navigationItem.rightBarButtonItem?.image = UIImage.init(named: "publish_menu_close")
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showTopAlphaView()
            self.showMenuView()
        }
    
    }
    
    func addTapGesture() -> Void {
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtPublishMenuViewController.dismissMenu))
        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: - LOAD VIEW
    func buildUI() -> Void {
  
    }
    
    func showTopAlphaView() -> Void {
        self.topAlphaView = self.rootNaviController?.view.resizableSnapshotView(from: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: 64), afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtPublishMenuViewController.dismissMenu))
        self.topAlphaView?.addGestureRecognizer(tap)
        
        AppDelegate.getRootWindow()?.addSubview(self.topAlphaView!)
        self.topAlphaView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(AppDelegate.getRootWindow()!)
            make.bottom.equalTo((AppDelegate.getRootWindow()?.snp.top)!).offset(64)
        })
    }
    
    func removeTopAlphaView() -> Void {
        self.topAlphaView?.removeFromSuperview()
        self.rootNaviController?.topViewController?.navigationItem.rightBarButtonItem?.image = UIImage.init(named: "icon_publish")
    }
    
    func showMenuView() -> Void {
        let menuView = UINib(nibName: "ArtPublishChoiceView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! ArtPublishChoiceView
        menuView.frame =  CGRect.init(x: 0, y: 64, width: SCREEN_W, height: 260)
        self.view.addSubview(menuView)
        self.view.insertSubview(menuView, belowSubview: self.topAlphaView!)
        menuView.center = CGPoint.init(x: SCREEN_W/2, y: -menuView.frame.size.height/2)
        
        
        UIView.animate(withDuration: 0.2) { 
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            menuView.center = CGPoint.init(x: SCREEN_W/2, y: menuView.frame.size.height/2 + 64)
        }
        self.menuView = menuView
    }
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTapGesture()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
