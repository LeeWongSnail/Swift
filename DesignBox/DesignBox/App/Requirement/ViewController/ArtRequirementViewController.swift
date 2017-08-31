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
    

    
    override func categoryNameList() -> [String]? {
        var titles = [String]()
        for index in 0...8 {
            let tabTitle = "标题".appending("\(index)")
            titles.append(tabTitle)
        }
        return titles
    }

}


