//
//  ArtArticle.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/9.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import ObjectMapper


class ArtArticleList: Mappable {
    
    var article: ArtArticle?
    var shareinfo: ArtShare?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        article <- map["article"]
        shareinfo <- map["share"]
    }
    
}

extension ArtArticleList:ArtMonkeyScrollViewProtocol {
    func getLineTitle() -> String? {
        return article?.title
    }
}

class ArtArticle: Mappable {

    var _id: String?
    var headpic: String?
    var showdate: String?
    var sortsids: [String]?
    var title: String?
    var sorts: [String]?
    var last_modified_time: CLongLong?
    var url: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _id   <- map["_id"]
        headpic <- map["headpic"]
        showdate <- map["showdate"]
        sortsids <- map["sortids"]
        title <- map["title"]
        sorts <- map["sorts"]
        last_modified_time <- map["last_modified_time"]
        url <- map["url"]
    }
}
