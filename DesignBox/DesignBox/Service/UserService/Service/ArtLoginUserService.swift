//
//  ArtLoginUserService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtLoginUserService: NSObject {

    //MARK: - Properties
    var loginUser: ArtUser?
    
    public func loginWithUserOperation(operation:ArtUserOperation,completed:@escaping (_ error:Error?) ->()) -> Void {
        let loginCommand = ArtCommandLogin()
        loginCommand.mobile = operation.mobile
        loginCommand.passwd = operation.passwd
        
        loginCommand.loginCommand(success: { (author) in
            self.loginUser = author
            completed(nil)
        }) { (aError) in
            completed(aError)
        }
    }
}
