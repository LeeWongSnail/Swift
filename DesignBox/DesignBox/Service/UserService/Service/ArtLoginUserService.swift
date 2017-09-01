//
//  ArtLoginUserService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtLoginUserService: NSObject {

    public func loginWithUserOperation(operation:ArtUserOperation,completed:(_ error:Error) ->()) -> Void {
        let loginCommand = ArtCommandLogin()
        loginCommand.mobile = operation.mobile
        loginCommand.passwd = operation.passwd
        
        loginCommand.loginCommand(success: { (author) in
            
        }) { (aError) in
            
        }
    }
}
