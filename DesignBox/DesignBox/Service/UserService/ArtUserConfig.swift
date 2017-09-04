//
//  ArtUserConfig.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/1.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import CryptoSwift


class ArtUserConfig: NSObject {

    //MARK: 单例
    static let shared = ArtUserConfig()
    private override init() {
    }
    
    var isLogin:Bool  {
        get {
            
            guard (ArtUserService.shared.loginUser != nil) else {
                return false
            }
            
            guard ArtUserService.shared.loginUser!._id != nil else {
                return false
            }
            
            
            return ArtUserService.shared.loginUser!._id!.characters.count > 0
        }
    }
    
    
    var userId: String {
        get {
            guard isLogin else {
                return ""
            }
            
            return (ArtUserService.shared.loginUser?._id!)!
        }
    }
    
    
    
    
    
    
    
    static let key = "541693271533634859518766627812890492810379158320023844493257416"
    static let iv = ""
    
    public  static  func Endcode_AES_ECB(strToEncode:String)->String {
        // 从String 转成data
        let data = strToEncode.data(using: String.Encoding.utf8)
        
        // byte 数组
        var encrypted: [UInt8] = []
        do {
            encrypted = try AES(key: key, iv: iv, blockMode: .CBC, padding: PKCS7()).encrypt(data!.bytes)
        } catch {
        }
        
        let encoded =  Data(encrypted)
        //加密结果要用Base64转码
        return encoded.base64EncodedString()
    }
    
    //  MARK:  AES-ECB128解密
    public static func Decode_AES_ECB(strToDecode:String)->String {
        //decode base64
        let data = NSData(base64Encoded: strToDecode, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        
        // byte 数组
        var encrypted: [UInt8] = []
        let count = data?.length
        
        // 把data 转成byte数组
        for i in 0..<count! {
            var temp:UInt8 = 0
            data?.getBytes(&temp, range: NSRange(location: i,length:1 ))
            encrypted.append(temp)
        }
        
        // decode AES
        var decrypted: [UInt8] = []
        do {
            decrypted = try AES(key: key, iv: iv, blockMode:.CBC, padding: PKCS7()).decrypt(encrypted)
        } catch {
        }
        
        // byte 转换成NSData
        let encoded = Data(decrypted)
        var str = ""
        //解密结果从data转成string
        str = String(bytes: encoded.bytes, encoding: .utf8)!
        return str
    }

    
    
}
