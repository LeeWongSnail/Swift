//
//  ArtCommandLogin.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtCommandLogin: ArtCommand {

    var mobile: String?
    var passwd: String?
    
    override func requestParams() -> [String : AnyObject] {
        var params = [String:AnyObject]()
        
        if let mob = mobile {
            params["mobile"] = mob as AnyObject
        }
        if let pwd = passwd {
            params["passwd"] = pwd as AnyObject
        }
        return params
    }
    
    
    public func loginCommand(success:@escaping (_ works:[ArtWork])->(),failure:@escaping (_ error:Error)->()) -> Void {
        startCommand(success: { (response) in
            //字典转模型
            print(response)
            DispatchQueue.main.async {
               
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    
    
    override init() {
        super.init() //如果缺少这句话会导致 self used before super.init call
        self.requestURL = "http://api.shejibao.com/v1/userlogin"
        self.requestType = .POST
    }
    
    
    
}
