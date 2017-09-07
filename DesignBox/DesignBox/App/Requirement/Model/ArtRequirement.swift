//
//  ArtRequirement.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/6.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ObjectMapper



class ArtRequirementList: Mappable {
    
    var orders:[String]?
    var author: ArtUser?
    var requirement: ArtRequirement?
//    var vipsupport: [String:AnyObject]?
//    var banner:[[String:AnyObject]]?
    var waitensure: [String:AnyObject]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        orders <- map["orders"]
        author <- map["author"]
        requirement <- map["requirement"]
//        vipsupport <- map["vipsupport"]
//        banner <- map["banner"]
        waitensure <- map["waitensure"]
    }
}



class ArtRequirement: Mappable {

    var _id: String?
    var state: Int?
    var orderno: String?
    var prepay: CGFloat?
    var budget: CGFloat?
    var viewcount: Int?
    var imgInfos: [String]?
    var imgHeight: CGFloat?
    var userid: String?
    var text: String?
    var target: String?
    var last_modified_time: String?
    var applydesigner: [String]?
    var recmddesigner: [String]?
    var refusedesigner: [String]?
    var waitensure: String?
    var consultant: String?
    var islock: Bool?
    var canop: Bool?
    var statedesc: String?
    var projectstate: String?
    var designerid: String?
    var supportcount: Int?
    var commentcount: Int?
    var hotcount: Int?
    var tags:[String]?
    var sorts: [String]?
    var noensure: String?
    var ensure: String?
    var showtype: Int?
    var redfont: String?
    var reqservicetel: String?
    var showcontact: Bool?
    var readme: String?
    var code: CLongLong?
    var create_at: String?
    var imgs: [AnyObject]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id <- map["_id"]
        state <- map["state"]
        orderno <- map["orderno"]
        prepay <- map["prepay"]
        budget <- map["budget"]
        viewcount <- map["viewcount"]
        imgInfos <- map["imgInfos"]
        imgHeight <- map["imgHeight"]
        userid <- map["userid"]
        text <- map["text"]
        target <- map["target"]
        last_modified_time <- map["last_modified_time"]
        applydesigner <- map["applydesigner"]
        recmddesigner <- map["recmddesigner"]
        refusedesigner <- map["refusedesigner"]
        waitensure <- map["waitensure"]
        consultant <- map["consultant"]
        islock <- map["islock"]
        canop <- map["canop"]
        statedesc <- map["statedesc"]
        projectstate <- map["projectstate"]
        designerid <- map["designerid"]
        supportcount <- map["supportcount"]
        commentcount <- map["commentcount"]
        hotcount <- map["hotcount"]
        tags <- map["tags"]
        sorts <- map["sorts"]
        noensure <- map["noensure"]
        ensure <- map["ensure"]
        showtype <- map["showtype"]
        redfont <- map["redfont"]
        reqservicetel <- map["reqservicetel"]
        showcontact <- map["showcontact"]
        readme <- map["readme"]
        code <- map["code"]
        create_at <- map["create_at"]
        imgs <- map["imgs"]
    }
    
}
