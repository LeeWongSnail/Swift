//
//  ArtShare.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/22.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ObjectMapper


class ArtShare: Mappable {
    var title: String?
    var icon: String?
    var url: String?
    var desc: String?
    var text: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title   <- map["title"]
        icon    <- map["icon"]
        url     <- map["url"]
        desc    <- map["desc"]
        text    <- map["text"]
    }
    
}
