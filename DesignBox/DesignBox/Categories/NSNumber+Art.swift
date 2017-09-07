//
//  NSNumber+Art.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/7.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation


extension NSNumber {    
    
    func timestampString() -> String {
        
        let timestamp = self.doubleValue/1000.0
        let current = Date().timeIntervalSince1970
        let offset = Int(current - timestamp)
        
        if offset < 60 {
            return "刚刚"
        }
        if offset < 60*60 {
            return String(offset/60).appending("分钟前")
        }
        
        if offset < 60*60*24 {
            return String(offset/3600).appending("小时前")
        }
        
        if offset < 60*60*24*2 {
            return "一天前"
        }
        
        if offset < 60*60*24*3 {
            return "两天前"
        }
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "zh_CN") as Locale!
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = Date(timeIntervalSince1970: timestamp)
        return formatter.string(from: date)
    }

}
