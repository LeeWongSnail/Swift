//
//  ArtCommandLogin.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ArtCommandLogin: ArtCommand {

    var mobile: String?
    var passwd: String?
    
    override func requestParams() -> [String : AnyObject] {
        var params = [String:AnyObject]()
        
        if let mob = mobile {
            params["mobile"] = mob as AnyObject
        }
        if passwd != nil {
            params["passwd"] = "c97554911e393c5cf451fa5b0c1f3f7b" as AnyObject
        }
        
        params["platform"] = "SJB" as AnyObject
        return params
    }
    
    
    public func loginCommand(success:@escaping (_ author:ArtUser)->(),failure:@escaping (_ error:Error)->()) -> Void {
        startCommand(success: { (response) in
            //字典转模型
            if let error = response.error {
                failure(error)
                return
            }
           
            let dict = response.dictionaryObject
            let author:ArtUser = Mapper<ArtUser>().map(JSONObject: dict)!
            print(author)
            DispatchQueue.main.async {
               success(author)
            }
        }) { (error) in
            failure(error)
            print(error)
        }
    }
    
    
    
    
    override init() {
        super.init() //如果缺少这句话会导致 self used before super.init call
        self.requestURL = "http://api.shejibao.com/v1/userlogin"
        self.requestType = .POST
    }
    
    
    
}
