//
//  ArtCommandMaterial.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/8.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ArtCommandMaterial: ArtCommand {
    
    var count: String?
    var pageno: Int?
    
    override func requestParams() -> [String : AnyObject] {
        let parameters:[String:AnyObject] = ["count":count as AnyObject,"pageno":pageno as AnyObject]
        return parameters
    }
    
    public func fetchMaterial(success:@escaping (_ works:[ArtMaterial],_ topics:[Any]?)->(),failure:@escaping (_ error:Error)->()) -> Void {
        startCommand(success: { (response) in
            //字典转模型
            print(response)
            let topics:JSON = response["topics"]
            let recommendlist:JSON = response["recommendlist"]
            let recommendArr:[ArtMaterial] = Mapper<ArtMaterial>().mapArray(JSONObject: recommendlist.object)!
            print(recommendArr)
            let topicsr = topics.arrayObject
            DispatchQueue.main.async {
                success(recommendArr,topicsr)
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    override init() {
        super.init() //如果缺少这句话会导致 self used before super.init call
        self.requestURL = "http://newapi.shejibao.com/api/v1/contentindex"
        self.requestType = .POST
    }
}
