//
//  ArtCommand.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/16.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


enum ArtCommandType {
    case UNKNOW
    case POST
    case GET
}


class ArtCommand: NSObject {
    var headers:HTTPHeaders?
    var params = [String:AnyObject]()
    var requestType:ArtCommandType = .POST
    var requestURL:String?
    
    
    func requestParams() -> [String:AnyObject] {
        return ["1":"2" as AnyObject]
    }
    
    
    func requestHeaders() -> HTTPHeaders? {
        var headers = HTTPHeaders()
        
        if ArtUserConfig.shared.isLogin {
            headers["userid"] = ArtUserConfig.shared.userId
        }
        
        return headers
    }
    
    
    func startCommand(success:@escaping (_ result:JSON)->(),failure:@escaping (_ error:Error)->()) -> Void {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        var httpMethod:HTTPMethod = .post
        
        
        self.params = requestParams()
        self.headers = requestHeaders()
        
        switch requestType {
        case .POST:
            httpMethod = .post
        case .GET:
            httpMethod = .get
        default:
            httpMethod = .options
        }
        
        Alamofire.request(requestURL!, method:httpMethod, parameters: params, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<300).responseJSON(queue: utilityQueue, options: JSONSerialization.ReadingOptions.allowFragments, completionHandler: { (response) in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    let json1 = JSON(json)
                    
                    success(json1)
                }
            case .failure(let error):
                failure(error)
            }
        
        })
        
    }
    
    
    
    
    
    
}
