//
//  ArtWork.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/16.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper


class ArtWork: Mappable{
    var _id: String?
    var userid: String?
    var city: String?
    var last_modified_time: String?
    var create_at: String?
    var supportcount: NSNumber?
    var commentcount: NSNumber?
    var collectcount: NSNumber?
    var viewcount: NSNumber?
    var hotcount: NSNumber?
    var choicetype: NSNumber?
    var logictype: NSNumber?
    var worktype: NSNumber?
    var status: NSNumber?
    var isoriginal: NSNumber?
    var tags:[AnyObject]?
    var sorts:[AnyObject]?
    var sortsname:[String]?
    var text: String?
    var imgInfos: [AnyObject]?
    var imgHeight: Float?
    var topicid: String?
    var topicname: String?
    var shareInfo: [String:AnyObject]?
    var collecttimestamp: NSNumber?
    var caseType: NSNumber?
    var virtual: NSNumber?
    var cheat: Bool?
    var supported: NSNumber?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id <- map["id"]
        userid <- map["userid"]
        city <- map["city"]
        last_modified_time <- map["last_modified_time"]
        create_at <- map["create_at"]
        supportcount <- map["supportcount"]
        commentcount <- map["commentcount"]
        collectcount <- map["collectcount"]
        viewcount    <- map["viewcount"]
        hotcount     <- map["hotcount"]
        choicetype   <- map["choicetype"]
        logictype    <- map["logictype"]
        worktype     <- map["worktype"]
        status       <- map["status"]
        isoriginal   <- map["isoriginal"]
        tags         <- map["tags"]
        sorts        <- map["sorts"]
        sortsname    <- map["sortsname"]
        text         <- map["text"]
        imgInfos     <- map["imgInfos"]
        imgHeight    <- map["imgHeight"]
        topicid      <- map["topicid"]
        topicname    <- map["topicname"]
        shareInfo    <- map["shareInfo"]
        collecttimestamp <- map["collecttimestamp"]
        caseType     <- map["caseType"]
        virtual      <- map["virtual"]
        cheat        <- map["cheat"]
        supported    <- map["supported"]
    }
    
}
