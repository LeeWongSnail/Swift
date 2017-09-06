//
//  UIColor+ArtStyle.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/23.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func art_mainGrayColor() ->UIColor {
        return UIColor.art_colorWithHexString(hexString: "1C1C1C")
    }
    
    public class func art_mainHighColor() ->UIColor {
        return UIColor.art_colorWithHexString(hexString: "FB1E36")
    }
    
    public class func art_backgroundColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "F2F2F2")
    }
    
    public class func art_mainColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "f64e4e")
    }
    
    public class func art_fontGrayColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "999999")
    }
    
    public class func art_fontColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "4d4d4d")
    }
    
    public class func art_sepLineHColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "d9d9d9")
    }
    
    public class func art_sepLineLColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "e3e3e3")
    }
    
    public class func art_naviBarColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "000000")
    }
    
    public class func art_linkColor() -> UIColor {
        return UIColor.art_colorWithHexString(hexString: "2bbff0")
    }
}
