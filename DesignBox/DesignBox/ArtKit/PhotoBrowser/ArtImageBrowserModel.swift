//
//  ArtImageBrowserModel.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/5.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtImageBrowserModel: NSObject,ArtFileItemProtocol {

    var imageURL:String?
    
    func getImageURL() -> String? {
        return imageURL
    }
    
}
