//
//  NSString+Art.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/24.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public func getTextHeigh(font:UIFont,width:CGFloat) -> Float {
        
        let size = CGSize(width: width, height: 1000)
        let dic = [NSFontAttributeName:font]
        
        let stringSize = (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic, context: nil).size
        
        return Float(stringSize.height)
    }
    
    public func getTexWidth(font:UIFont,height:CGFloat) -> Float {
        
        let size = CGSize(width: 1000, height: height)
        let dic = [NSFontAttributeName:font]
        
        let stringSize = (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic, context: nil).size
        
        return Float(stringSize.width+5.0)
        
    }
    
}
