//
//  ArtRequirement.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper


class ArtCommandRequirementList: ArtCommand {
    var count: String?
    var time: CLongLong?
    var vcount: String?
    var bybudget: CGFloat?
    var sortid: String?
    var showtype: Int?
    var budget: CGFloat?
    
    override func requestParams() -> [String : AnyObject] {
        let parameters:[String:AnyObject] = ["count":count as AnyObject,"vcount":vcount as AnyObject,"time":time as AnyObject,"bybudget":bybudget as AnyObject, "sortid":sortid as AnyObject, "showtype":showtype as AnyObject, "budget": budget as AnyObject]
        return parameters
    }
    
    public func fetchRequirement(success:@escaping (_ works:[ArtRequirementList],_ bannerList:ArtBannerList)->(),failure:@escaping (_ error:Error)->()) -> Void {
        startCommand(success: { (response) in
            //字典转模型
            print(response)
            let requirements:JSON = response["list"]
            let banner:JSON = response["banner"]
            let requrementArr:[ArtRequirementList] = Mapper<ArtRequirementList>().mapArray(JSONObject: requirements.object)!
            print(requrementArr)
            let banners:[ArtBanner] = Mapper<ArtBanner>().mapArray(JSONObject: banner.object)!
            let bannerList = ArtBannerList()
            bannerList.banners = banners
            DispatchQueue.main.async {
                success(requrementArr,bannerList)
            }
        }) { (error) in
            print(error)
        }
    }
    
    override init() {
        super.init() //如果缺少这句话会导致 self used before super.init call
        self.requestURL = "http://api.shejibao.com/v1/requirementlist"
        self.requestType = .POST
    }
}
