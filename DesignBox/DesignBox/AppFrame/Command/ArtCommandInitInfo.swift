//
//  ArtCommandInitInfo.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtCommandInitInfo: ArtCommand {
    var sortid: String?
    var sorttype: String?
    
    override func requestParams() -> [String : AnyObject] {
        let parameters:[String:AnyObject] = ["sortid":sortid as AnyObject,"sorttype":sorttype as AnyObject]
        return parameters
    }
    
    
    func fetchSort() -> Void {
        startCommand(success: { (response) in
            let arr = response["list"].arrayObject
            ArtUserConfig.shared.reqCategory = arr as? Array<[String : Any]>
        }) { (error) in
            
        }
    }
    
    
    override init() {
        super.init() //如果缺少这句话会导致 self used before super.init call
        self.requestURL = "http://api.shejibao.com/v1/getsorts"
        self.requestType = .POST
    }
}
