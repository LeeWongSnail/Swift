//
//  ArtPublishWorkViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/11.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtPublishWorkViewController: UIViewController {

    
    //MARK: -CUSTOM METHOD
    func backDidClick() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextStep() -> Void {
        
    }
    
    //MARK: - LOAD VIEW
    func configNavItems() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtPublishWorkViewController.backDidClick))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtPublishWorkViewController.nextStep))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        configNavItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
