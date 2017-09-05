//
//  ArtUser.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/22.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ObjectMapper

class ArtUser: Mappable {
    var _id: String?
    var nickname: String?
    var icon: String?
    var gender: Int?
    var desc: String?
    var sdesc: String?
//    var dirtags: [String]?
//    var dirtagsids: [String]?
    var worktime: String?
    var worktimeid: String?
    var workplaceid: String?
    var workplace: String?
    var graduation_school: String?
    var graduation_schoolid: String?
    var level: Int?
    var ischeck: Int?
    var mobile: String?
    var token: String?
    var number: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id             <- map["userid"]
        nickname        <- map["nickname"]
        icon            <- map["icon"]
        gender          <- map["gender"]
        desc            <- map["desc"]
        sdesc           <- map["sdesc"]
//        dirtags         <- map["dirtags"]
//        dirtagsids      <- map["dirtagsids"]
        worktime        <- map["worktime"]
        worktimeid      <- map["worktimeid"]
        workplaceid     <- map["workplaceid"]
        workplace       <- map["workplace"]
        level           <- map["level"]
        ischeck         <- map["ischeck"]
        mobile          <- map["mobile"]
        token           <- map["token"]
        number          <- map["number"]
        
        
        graduation_school <- map["graduation_school"]
        graduation_schoolid <- map["graduation_schoolid"]
    }
    
}
