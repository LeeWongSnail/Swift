//
//  ArtImageService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/25.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Kingfisher

class ArtImageService: NSObject {
    
    static let shared = ArtImageService()
    private override init() {
        
    }
    
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

}
