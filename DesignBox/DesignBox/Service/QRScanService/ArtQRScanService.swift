//
//  ArtQRScanService.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/13.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import AVFoundation


class ArtQRScanService: NSObject {

    
    var scanResultBlock:((_ qrCode:String) -> Void)?
    var session: AVCaptureSession?
    
    static let shared = ArtQRScanService()
    private override init() {
        super.init()
    }
    
    func resetScanService() -> Void {
        self.session?.stopRunning()
        self.session?.startRunning()
    }
    
    
    func startScan(windowSize:CGRect,viewSize:CGRect,result:@escaping (_ qrCode:String)->Void) -> AVCaptureVideoPreviewLayer? {
        self.scanResultBlock = result
        return creatCaptureDevice(windowSize: windowSize, viewSize: viewSize)
    }
    
    
    func creatCaptureDevice(windowSize:CGRect,viewSize:CGRect) -> AVCaptureVideoPreviewLayer? {
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        var input:AVCaptureDeviceInput?
        do {
            try input = AVCaptureDeviceInput.init(device: device)
        } catch let error as NSError {
            print ("Error: \(error.domain)")
        }
        
        guard input != nil else {
            return nil
        }
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        let scanCrop = getScanCrop(rect: windowSize, readerViewBounds: viewSize)
        output.rectOfInterest = scanCrop
        
        self.session = AVCaptureSession()
        session?.addInput(input)
        session?.addOutput(output)
        
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
        
        
        let layer = AVCaptureVideoPreviewLayer.init(session: self.session!)
        layer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer?.frame = viewSize
        
        self.session?.startRunning()
        
        return layer
    }
    
    
    func getScanCrop(rect:CGRect,readerViewBounds:CGRect) -> CGRect {
        
        let x = (rect.origin.y + 64)/(readerViewBounds.size.height)
        let y = rect.origin.x/readerViewBounds.size.width
        let width = rect.size.height/readerViewBounds.size.height
        let height = rect.size.width/readerViewBounds.size.width
        
        return CGRect(x: x, y: y, width: width, height: height)
        
    }
    
}


extension ArtQRScanService: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            self.session?.stopRunning()
            let metadataObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            if self.scanResultBlock != nil {
                self.scanResultBlock!(metadataObject.stringValue)
            }
        }
        
    }
    
    
    
    
    
}
