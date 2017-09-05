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
    var loginUser: ArtUser? {
        get {
            
            if let userid = ArtUserConfig.shared.userId {
                if let cacheUser = ArtUserDBService.shared.fetchUser(userId: userid) {
                    return ArtUser(JSON: cacheUser)
                }
            }
            
            return nil
        }
        set {
            ArtUserConfig.shared.userId = newValue?._id
        }
    }
    
    public func loginWithUserOperation(operation:ArtUserOperation,completed:@escaping (_ error:Error?) ->()) -> Void {
        let loginCommand = ArtCommandLogin()
        loginCommand.mobile = operation.mobile
        loginCommand.passwd = operation.passwd
        loginCommand.icon = operation.icon
        loginCommand.nickname = operation.nickname
        loginCommand.openid = operation.openid
        loginCommand.platform = operation.platform
        
        loginCommand.loginCommand(success: { (author) in
            self.loginUser = author
            
            ArtUserDBService.shared.insertUser(user: author)
            ArtUserConfig.shared.saveUserConfig()
            completed(nil)
        }) { (aError) in
            completed(aError)
        }
    }
    
    func fetchLoginUserInfo(completed:@escaping (_ cmd:ArtCommandUser?,_ error:Error?) ->()) -> Void {
        
        let userinfoCmd = ArtCommandUser()
    
        userinfoCmd.fetchUserCommand(success: { (user) in
            completed(userinfoCmd,nil)
        }) { (error) in
            print(error)
            completed(nil,error)
        }
        
    }
}
