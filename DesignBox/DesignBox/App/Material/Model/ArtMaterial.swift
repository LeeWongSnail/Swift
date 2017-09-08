//
//  ArtMaterial.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/8.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ObjectMapper

class ArtMaterial: Mappable {

    var imgs: [AnyObject]?
    var label: [AnyObject]?
    var last_modified_time: String?
    var filesize: CGFloat?
    var _id: String?
    var create_at: CLongLong?
    var imgModel: AnyObject?
    var format: String?
    var keep: Int?
    var name: String?
    var imgsize: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id <- map["_id"]
        imgs <- map["imgs"]
        label <- map["label"]
        last_modified_time <- map["last_modified_time"]
        filesize <- map["filesize"]
        create_at <- map["create_at"]
        imgModel <- map["imgModel"]
        format <- map["format"]
        keep <- map["keep"]
        name <- map["name"]
        imgsize <- map["imgsize"]
    }
}
