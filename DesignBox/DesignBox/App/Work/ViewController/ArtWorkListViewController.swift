//
//  ArtWorkListViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/15.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Alamofire

class ArtWorkListViewController: UIViewController {

    //MARK 获取网络数据
    func fetchData() -> Void {
        let parameters: Parameters = ["count": "20","order":"1"]
        
        Alamofire.request("http://api.shejibao.com/v1/worklist", method: .post, parameters:parameters , encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response);
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
