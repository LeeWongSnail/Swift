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

    
    //图片缓存目录
    let myCache = ImageCache(name:"my_cache")
    
    
    //图片缓存的相关配置
    func art_imageConfig() -> Void {
        let downloader = KingfisherManager.shared.downloader
        // 修改超时时间
        downloader.downloadTimeout = 5
        
        let cache = KingfisherManager.shared.cache
        
        // 设置硬盘最大缓存50M ，默认无限
        cache.maxDiskCacheSize = 50 * 1024 * 1024
        // 设置硬盘最大保存3天 ， 默认1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
    }
    
    
    //获取缓存文件的大小
    func art_getCacheSize(completion:@escaping (_ size:UInt)->()) -> Void {
        // 获取硬盘缓存的大小
        let cache = KingfisherManager.shared.cache

        cache.calculateDiskCacheSize(completion: { (size) in
            completion(size)
        })
    }
    
    
    //清除缓存 包括 内存缓存 磁盘缓存
    func art_cleanCache() -> Void {
        let cache = KingfisherManager.shared.cache

        //清理内存缓存
        cache.clearMemoryCache()

        // 清理硬盘缓存，这是一个异步的操作
        cache.clearDiskCache()

        // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
        cache.cleanExpiredDiskCache()
    }
    
    
    
    //MARK: - 设置图片
    func art_setImageWithURL(imageURL:String?) -> Void {
        var url:URL?
        if let pic = imageURL {
            url = URL(string: pic)!
        } 
        self.kf.setImage(with: url)
    }
    
    func art_setImageWith(imageURL:String?,placeholder:UIImage) -> Void {
        var url:URL?
        
        if let imgURL = imageURL {
            url = URL(string: imgURL)
        }
        
        self.kf.setImage(with: url, placeholder: placeholder, options:nil, progressBlock: { (receivedSize, totalSize) in
            
        }) { (image, error, cacheType, imageURL) in
            
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
