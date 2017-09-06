//
//  ArtRequirementViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/25.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtRequirementViewController: ArtPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildMainView()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func createControllerByIndex(index: Int) -> UIViewController? {
        let vc = UIViewController()
        if index%2==0 {
            vc.view.backgroundColor = UIColor.red
        } else {
            vc.view.backgroundColor = UIColor.yellow
        }
        return vc
    }
    
    override func categoryNameList() -> [String]? {
        var titles = [String]()
        for item in ArtUserConfig.shared.reqCategory! {
            let title = item["name"] as? String
            titles.append(title!)
        }
        return titles
    }

}


