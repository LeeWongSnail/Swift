//
//  ArtDBService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/4.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SQLite


class ArtDBService: NSObject {
    
    
    var userDBService:ArtUserDBService = ArtUserDBService.shared
    
    
    static let shared = ArtDBService()
    private override init() {
        super.init()
   
    }
    
    
}
