//
//  ArtBanner.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ObjectMapper


class ArtBanner: Mappable {
    var _id: String?
    var url: String?
    var imgurl:String?
    var imgheight:CGFloat?
    var imgwidth: CGFloat?
    var title: String?
    var opentype: Int?
    var contentid: String?
    var desc: String?
    var adoffset: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id <- map["_id"]
        url <- map["url"]
        imgurl <- map["imgurl"]
        imgheight <- map["imgheight"]
        imgwidth <- map["imgwidth"]
        title <- map["title"]
        opentype <- map["opentype"]
        contentid <- map["contentid"]
        desc <- map["desc"]
        adoffset <- map["adoffset"]
    }
}


class ArtBannerList: NSObject {
    var banners: [ArtBanner]?
    var currentPage: Int = 0
}
