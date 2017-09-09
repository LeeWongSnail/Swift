//
//  ArtWorkCommand.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/16.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

class ArtWorkCommand: ArtCommand {
    var count:String = "20"
    var order:String?
    
    override func requestParams() -> [String : AnyObject] {
        let parameters:[String:AnyObject] = ["count":count as AnyObject,"order":order as AnyObject]
        return parameters
    }
    
    override func requestHeaders() -> [String:String]? {
        return nil
    }
    
    public func fetchWork(success:@escaping (_ works:[ArtWork],_ bannerList:ArtBannerList,_ headlines:[ArtArticleList])->(),failure:@escaping (_ error:Error)->()) -> Void {
        startCommand(success: { (response) in
            //字典转模型
            print(response)
            let works:JSON = response["works"]
            let banner:JSON = response["banner"]
            let headpic:JSON = response["headline"]
            let workArr:[ArtWork] = Mapper<ArtWork>().mapArray(JSONObject: works.object)!
            let banners:[ArtBanner] = Mapper<ArtBanner>().mapArray(JSONObject: banner.object)!
            let headlines:[ArtArticleList] = Mapper<ArtArticleList>().mapArray(JSONObject: headpic.object)!
            let bannerList = ArtBannerList()
            bannerList.banners = banners
            print(works)
            print(banners)
            DispatchQueue.main.async {
                success(workArr,bannerList,headlines)
            }
        }) { (error) in
            print(error)
        }
    }
    
    override init() {
        super.init() //如果缺少这句话会导致 self used before super.init call
        self.requestURL = "http://api.shejibao.com/v1/worklist"
        self.requestType = .POST
    }
}
