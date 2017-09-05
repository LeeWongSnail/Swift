//
//  ArtUserDBService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/4.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON

class ArtUserDBService: NSObject {
    
    public var db:Connection!
    
    static let shared = ArtUserDBService()
    private override init() {
        super.init()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        self.db = try? Connection("\(path)//db.sqlite3")
        self.createUserTable()
    }
    
    var users:Table = Table("users")
    let _id = Expression<String>("_id")
    let nickname = Expression<String?>("nickname")
    let icon = Expression<String?>("icon")
    let gender = Expression<Int?>("gender")
    let desc = Expression<String?>("desc")
    let sdesc = Expression<String?>("sdesc")
    //        let dirtags = Expression<[String]>("dirtags")
    //        let dirtagsids = Expression<[String]>("dirtagsids")
    let worktime = Expression<String?>("worktime")
    let worktimeid = Expression<String?>("worktimeid")
    let workplace = Expression<String?>("workplace")
    let workplaceid = Expression<String?>("workplaceid")
    let graduation_school = Expression<String?>("graduation_school")
    let graduation_schoolid = Expression<String?>("graduation_schoolid")
    let level = Expression<Int?>("level")
    let ischeck = Expression<Int?>("ischeck")
    let mobile = Expression<String?>("mobile")
    let token = Expression<String?>("token")
    let number = Expression<String?>("number")
    
    
    
    func createUserTable() -> Void {

        try! db?.run(users.create(ifNotExists: true, block: { (table) in
            table.column(_id, primaryKey: true)
            table.column(nickname,defaultValue:"")
            table.column(icon)
            table.column(gender,defaultValue:0)
            table.column(desc,defaultValue:"")
            table.column(sdesc,defaultValue:"")
//            table.column(dirtags,[String])
//            table.column(dirtagsids)
            table.column(worktime,defaultValue:"")
            table.column(worktimeid,defaultValue:"")
            table.column(workplace,defaultValue:"")
            table.column(workplaceid,defaultValue:"")
            table.column(graduation_school,defaultValue:"")
            table.column(graduation_schoolid,defaultValue:"")
            table.column(level,defaultValue:0)
            table.column(ischeck,defaultValue:0)
            table.column(mobile,defaultValue:"")
            table.column(token,defaultValue:"")
            table.column(number,defaultValue:"")
        }))
    }
    

    public func insertUser(user:ArtUser) -> Void {
        
        //插入用户 先判断是否存在
        var isExist: Bool = false
        for user1 in (try! db?.prepare(users))! {
            if user1[_id] == user._id {
                isExist = true
            }
        }
        
        if !isExist {
            
            let insert = users.insert(nickname <- user.nickname ?? "",_id <- user._id ?? "",icon <- user.icon ?? "",gender <- user.gender ?? 0,desc <- user.desc ?? "",sdesc  <- user.sdesc ?? "",worktime <- user.worktime ?? "", worktimeid <- user.worktimeid ?? "", workplace <- user.workplace ?? "",workplaceid <- user.workplaceid ?? "",
                                      graduation_school <- user.graduation_school ?? "",graduation_schoolid <- user.graduation_schoolid ?? "",level <- user.level ?? 0,ischeck <- user.ischeck ?? 0, mobile <- user.mobile ?? "", token <- user.token ?? "",number <- user.number ?? "")
            
            try! db.run(insert)
        }
    }
    
    public func fetchUser(userId:String) -> [String:AnyObject]? {
    
        for user in (try! db?.prepare(users))! {
            if user[_id] == userId {
            
                var desUser:[String:AnyObject] = [String:AnyObject]()
                desUser["_id"]              =  user[_id] as AnyObject
                desUser["nickname"]         =  user[nickname] as AnyObject
                desUser["icon"]             =  user[icon] as AnyObject
                desUser["gender"]           =  user[gender] as AnyObject
                desUser["desc"]             =  user[desc] as AnyObject
                desUser["sdesc"]            =  user[sdesc] as AnyObject
                desUser["worktime"]         =  user[worktime] as AnyObject
                desUser["worktimeid"]       =  user[worktimeid] as AnyObject
                desUser["workplaceid "]     =  user[workplaceid] as AnyObject
                desUser["workplace "]       =  user[workplace] as AnyObject
                desUser["level"]            =  user[level] as AnyObject
                desUser["ischeck"]          =  user[ischeck] as AnyObject
                desUser["mobile"]           =  user[mobile] as AnyObject
                desUser["token"]            =  user[token] as AnyObject
                desUser["number"]           =  user[number] as AnyObject
                desUser["graduation_school"]     =  user[graduation_school] as AnyObject
                desUser["graduation_schoolid"]     =  user[graduation_schoolid] as AnyObject
                
                return desUser
            }
        }
        
        return nil
    }
    
    
    
    
}
