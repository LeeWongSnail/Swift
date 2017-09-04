//
//  ArtCommandUser.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/4.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ArtCommandUser: ArtCommand {

    var numberInfo:[String:Any]?

    
    
    public func fetchUserCommand(success:@escaping (_ author:ArtUser)->(),failure:@escaping (_ error:Error)->()) -> Void {
        startCommand(success: { (response) in
            //字典转模型
            if let error = response.error {
                failure(error)
                return
            }
            
            let dict = response.dictionaryObject
            let author:ArtUser = Mapper<ArtUser>().map(JSONObject: dict!["user"])!
            if author._id == nil {
                let info = dict?["user"] as! [String:AnyObject]
                author._id = info["_id"] as? String
            }
            
            self.numberInfo = dict
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
        self.requestURL = "http://api.shejibao.com/v1/mine"
        self.requestType = .POST
    }
    
}
