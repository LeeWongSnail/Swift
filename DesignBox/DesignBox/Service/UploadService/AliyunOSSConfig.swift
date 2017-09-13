//
//  AliyunOSSConfig.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/12.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class AliyunOSSConfig: NSObject {

    static let shared = AliyunOSSConfig()
    private override init() {
        super.init()
        
    }
    
    
    let host = "http://oss-cn-shanghai.aliyuncs.com"
    
    let bucketName = "evcos"
    
    let stsurl = "https://api.evcos.wm-motor.com/v1/oss/sts"
}
