//
//  ArtUserService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtUserService: NSObject {
    //MARK: 单例
    static let shared = ArtUserService()
    private override init() {
        self.loginUserService = ArtLoginUserService()
    }
    
    
    //MARK: Properties
    var loginUserService: ArtLoginUserService
    var loginUser: ArtUser?  {
        get {
            return self.loginUserService.loginUser
        }
    }
    
    
    
    //MARK: Functions
    
    func loginWithUserOperation(operation:ArtUserOperation,completed:@escaping (_ error:Error?) ->()) -> Void {
        self.loginUserService.loginWithUserOperation(operation: operation, completed: completed)
    }
    
    
}
