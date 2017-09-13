//
//  ArtScanViewController.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/13.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
let kScanRect = CGRect(x: 50, y: 38, width: 275, height: 275)

class ArtScanViewController: UIViewController {

    
    //MARK: SCAN
    func startScan() -> Void {
        self.view.layer .insertSublayer(ArtQRScanService.shared.startScan(windowSize: kScanRect, viewSize: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H), result: { (qrCode) in
            print(qrCode)
            self.showText(text: qrCode)
        })!, at: 0)
    }
    
    
    
    //MARK: BUILD UI
    
    func setupScanWindowView() -> Void {
        
        let scanH = kScanRect.size.height
        self.maskView.addSubview(self.scanWindow)
        self.scanWindow.snp.makeConstraints { (make) in
            make.width.height.equalTo(scanH)
            make.left.equalTo(self.view.snp.left).offset(kScanRect.origin.x)
            make.top.equalTo(self.view.snp.top).offset(kScanRect.origin.y)
        }
        
        let buttonWH = 26
        
        let topLeft = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWH, height: buttonWH))
        topLeft.setImage(UIImage.init(named: "scan_1"), for: UIControlState.normal)
        self.scanWindow.addSubview(topLeft)
        topLeft.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.scanWindow)
            make.width.height.equalTo(buttonWH)
        }
        
        let topRight = UIButton(frame: CGRect(x: Int(scanH - CGFloat(buttonWH)), y: 0, width: buttonWH, height: buttonWH))
        topRight.setImage(UIImage.init(named: "scan_2"), for: UIControlState.normal)
        self.scanWindow.addSubview(topRight)
        topRight.snp.makeConstraints { (make) in
            make.top.right.equalTo(self.scanWindow)
            make.width.height.equalTo(buttonWH)
        }
        
        let bottomLeft = UIButton(frame: CGRect(x: 0, y: Int(scanH - CGFloat(buttonWH)), width: buttonWH, height: buttonWH))
        bottomLeft.setImage(UIImage.init(named: "scan_3"), for: UIControlState.normal)
        self.scanWindow.addSubview(bottomLeft)
        bottomLeft.snp.makeConstraints { (make) in
            make.bottom.left.equalTo(self.scanWindow)
            make.width.height.equalTo(buttonWH)
        }
        
        let bottomRight = UIButton(frame: CGRect(x:topRight.frame.origin.x, y: bottomLeft.frame.origin.y, width: CGFloat(buttonWH), height: CGFloat(buttonWH)))
        bottomRight.setImage(UIImage.init(named: "scan_4"), for: UIControlState.normal)
        self.scanWindow.addSubview(bottomRight)
        bottomRight.snp.makeConstraints { (make) in
            make.bottom.right.equalTo(self.scanWindow)
            make.width.height.equalTo(buttonWH)
        }
        
    }
    
    func resumeAnimation() -> Void {
        
        let anim = self.scanNetImageView.layer.animation(forKey: "translationAnimation")
        
        if anim != nil {
            
            let pauseTime = self.scanNetImageView.layer.timeOffset
            let beginTime = CACurrentMediaTime() - pauseTime
            
            self.scanNetImageView.layer.timeOffset = 0.0
            self.scanNetImageView.layer.beginTime = beginTime
            self.scanNetImageView.layer.speed = 1.0
            
        } else {
        
            let scanNetImageViewH = kScanRect.size.height
            let scanWindowH = kScanRect.size.height
            let scanNetImageW = kScanRect.size.width
            
            self.scanNetImageView.frame = CGRect(x: 0, y: -scanNetImageViewH, width: scanNetImageW, height: scanNetImageViewH)
            let scanNetAnimation = CABasicAnimation()
            scanNetAnimation.keyPath = "transform.translation.y"
            scanNetAnimation.byValue = scanWindowH
            scanNetAnimation.duration = 1
            scanNetAnimation.repeatCount = MAXFLOAT
            
            self.scanNetImageView.layer.add(scanNetAnimation, forKey: "translationAnimation")
            self.scanWindow.addSubview(self.scanNetImageView)
        }
        
    }
    
    
    func buildUI() -> Void {
        
        self.view.addSubview(self.maskView)
        self.maskView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.maskView)
        }
        
        
        setupScanWindowView()
        resumeAnimation()
        startScan()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        buildUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.maskView.holePath = UIBezierPath(rect: kScanRect)
        self.maskView.viewColor = UIColor(white: 0, alpha: 0.6)
        self.maskView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    lazy var scanWindow = { () -> UIView in
        let tempWindow = UIView()
        
        tempWindow.clipsToBounds = true
        
        return tempWindow
    }()
    
    
    lazy var scanNetImageView = { () -> UIImageView in 
        let tempNetImage = UIImageView()
        
        tempNetImage.image = UIImage.init(named: "scan_net")
        
        return tempNetImage
    }()
    
    
    lazy var maskView = { () -> ArtScanView in 
        let tempMask = ArtScanView()
        
         tempMask.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
        
        return tempMask
    }()
}


extension ArtScanViewController {
    

    
}
