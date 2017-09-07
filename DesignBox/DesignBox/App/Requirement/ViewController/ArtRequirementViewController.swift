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
        
        configNavBar()
        // Do any additional setup after loading the view.
    }
    
    func scan() -> Void {
        
    }
    
    func publish() -> Void {
        
    }
    
    func configNavBar() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "navi_bar_search"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtWorkListViewController.scan))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "pulish"), style: UIBarButtonItemStyle.done, target: self, action: #selector(ArtWorkListViewController.publish))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func createControllerByIndex(index: Int) -> UIViewController? {
        let vc = ArtRequirementListController()
        if let item = ArtUserConfig.shared.reqCategory?[index] {
            vc.sortid = item["_id"] as? String
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


