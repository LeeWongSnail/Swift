//
//  ArtStyle.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/24.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation
import UIKit

//CGSize art_caculateWorkImageSize(CGFloat width, CGSize size)
//{
//    if (size.width == 0 || size.height == 0) {
//        return CGSizeMake(width, width);
//    }
//    CGFloat h = size.height * (width / size.width);
//    
//    if (h > width*2.) {
//        h = width*2.;
//    }
//    
//    return CGSizeMake(width, h);
//}



class ArtStyle {
    
    static let shared = ArtStyle.init()
    private init(){}
    
    
    public let art_workGridImageWidth: Float = {
        var width:Float = Float((SCREEN_W - 20.0 - 10.0)/3.0);
        return width;
    }()
    
    public let art_scrollTabMargin: CGFloat = {
        return 12
    }()
    
    
    public func art_caculateWorkImageSize(width:CGFloat,size:CGSize) -> CGSize {
        if size.width == 0 || size.height == 0 {
            return CGSize(width: width, height: width)
        }
        
        var h = size.height * (width/size.width)
        
        if h > width * 2 {
            h = width * 2
        }
        
        return CGSize(width: width, height: h)
    }
    
}
