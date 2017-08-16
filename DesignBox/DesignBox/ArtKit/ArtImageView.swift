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

    let myCache = ImageCache(name:"my_cache")
    
    
    func imageConfig() -> Void {
        let downloader = KingfisherManager.shared.downloader
        // 修改超时时间
        downloader.downloadTimeout = 5
        
        let cache = KingfisherManager.shared.cache
        
        // 设置硬盘最大缓存50M ，默认无限
        cache.maxDiskCacheSize = 50 * 1024 * 1024
        // 设置硬盘最大保存3天 ， 默认1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
    }
    
    
    func getCacheSize() -> Void {
        // 获取硬盘缓存的大小
//        cache.calculateDiskCacheSizeWithCompletionHandler { (size) -> () in
//            print(size)
//        }
        
        
        
//        //清理内存缓存
//        cache.clearMemoryCache()
//        
//        // 清理硬盘缓存，这是一个异步的操作
//        cache.clearDiskCache()
//        
//        // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
//        cache.cleanExpiredDiskCache()
    }
    
    
    func setImageWithURL(imageURL:String) -> Void {
        let url = URL(string: imageURL)
        self.kf.setImage(with: url)
    }
    
    func setImageWith(imageURL:String,placeholder:UIImage) -> Void {
        let url = URL(string: imageURL)
        self.kf.setImage(with: url, placeholder: placeholder, options:nil, progressBlock: { (receivedSize, totalSize) in
            
        }) { (image, error, cacheType, imageURL) in
            
        }
    }
    

    
    //MARK: - Cancel Image Downloader
    func cancelImageDownload(imageURL:String) -> Void {
        let task = self.kf.setImage(with: URL(string: imageURL))
        task.cancel()
    }
    
    
}
