//
//  AliyunOSSService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/12.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AliyunOSSiOS

class AliyunOSSService: NSObject {

    static let shared = AliyunOSSService()
    var client:OSSClient?
    private override init() {
        super.init()
        initClient()
    }

    
    
    //初始化上传设置
    func initClient() {
        
        //上传配置设置
        let conf = OSSClientConfiguration()
        conf.maxRetryCount = 2
        conf.timeoutIntervalForRequest = 300
        conf.timeoutIntervalForResource = TimeInterval(24 * 60 * 60)
        conf.maxConcurrentRequestCount = 50
        
        //实现获取StsToken回调
        let credential2:OSSCredentialProvider = OSSFederationCredentialProvider.init(federationTokenGetter: { () -> OSSFederationToken? in
            
            let tcs = OSSTaskCompletionSource<AnyObject>.init()
            
            Alamofire.request(AliyunOSSConfig.shared.stsurl, method: .get, parameters: [: ])
                .responseJSON { (response) in
                    
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        let state = json["success"].intValue
                        if state == 1{
                            tcs.setResult(json as AnyObject?)
                        }else{
                            tcs.setError("error" as! Error)
                        }
                    }
            }
            
            tcs.task.waitUntilFinished()
            
            if tcs.task.error != nil {
                return nil
            }else {
                
                let jsonData:JSON = JSON(tcs.task.result as AnyObject),
                tokenInfo:OSSFederationToken = OSSFederationToken()
                
  
                tokenInfo.tAccessKey = jsonData["accessKeyId"].stringValue
                tokenInfo.tSecretKey = jsonData["accessKeySecret"].stringValue
                tokenInfo.tToken = jsonData["token"].stringValue
                tokenInfo.expirationTimeInGMTFormat = jsonData["expiration"].stringValue
                
                return tokenInfo
            }
            
        })
        
        //实例化
        client = OSSClient(endpoint: AliyunOSSConfig.shared.host, credentialProvider: credential2, clientConfiguration: conf)
        
        
        
    }
    
    
    
    func uploadImage(image:UIImage) -> Void {
        if let data = UIImageJPEGRepresentation(image, 1) {
            upload(data: data)
        }
    }
    
    
    func upload(data:Data) -> Void {
        
        let put = OSSPutObjectRequest()
        put.bucketName = AliyunOSSConfig.shared.bucketName
        let timestampStr = "\(NSDate().timeIntervalSince1970)"
        
        put.objectKey = "app/imgs/driving/".appending(timestampStr).appending(".jpg")
        put.uploadingData = data
        // 设置Content-Type，可选
        put.contentType = "application/octet-stream"
        // 设置MD5校验，可选
         put.contentMd5 = OSSUtil.base64Md5(for: data)// 如果是二进制数据
        put.uploadProgress = { (bytesSent:Int64, totalByteSent: Int64,totalBytesExpectedToSend: Int64)-> Void in
            print((totalByteSent-totalBytesExpectedToSend)/totalByteSent * 100)
        }
        
        let putTask = self.client?.putObject(put)
        putTask?.continue({ (task) -> Any? in
            
            if (task.error != nil) {
                print(task.error!)
                return nil
            }
            let imageurl = self.getUrlStringForBucketName(aBucketName: AliyunOSSConfig.shared.bucketName, aEndpoint: AliyunOSSConfig.shared.host, aObjectKey: put.objectKey);
            print(imageurl)
            print("上传成功")
            return nil
        })
    }
    
    func getUrlStringForBucketName(aBucketName:String,aEndpoint:String,aObjectKey:String) -> String {
        // 拼接链接
        let http = "http://"
        
        let range = aEndpoint.range(of: http)
        var str = aEndpoint
        str.removeSubrange(range!)
        return http.appending(aBucketName).appending(".").appending(str).appending(aObjectKey)
    }
    
}
