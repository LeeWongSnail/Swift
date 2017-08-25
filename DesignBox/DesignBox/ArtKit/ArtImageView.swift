//
//  ArtImageView.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/16.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Kingfisher

class ArtImageView: UIImageView {

    let placeHolder = UIImage(named: "picture_default")
    
        
    
    
    //MARK: - 设置图片
    func art_setImageWithURL(imageURL:String?) -> Void {
        self.art_setImageWith(imageURL: imageURL, placeholder: placeHolder!)
    }
    
    func art_setImageWith(imageURL:String?,placeholder:UIImage) -> Void {
        var url:URL?
        
        
        self.image = placeholder
        if let imgURL = imageURL {
            url = URL(string: imgURL)
            self.kf.setImage(with: url, placeholder: placeholder, options:nil, progressBlock: { (receivedSize, totalSize) in
                
            }) { (image, error, cacheType, imageURL) in
                
            }
        }
        
    }
    
    func art_setWithImage(image:UIImage) -> Void {
        self.art_setImageWith(imageURL: nil, placeholder: image)
    }

    
    //MARK: - Cancel Image Downloader
    func art_cancelImageDownload(imageURL:String) -> Void {
        let task = self.kf.setImage(with: URL(string: imageURL))
        task.cancel()
    }
    
    
}
