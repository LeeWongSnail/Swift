//
//  ArtStyle.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/24.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import Foundation
import UIKit

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
    
}
