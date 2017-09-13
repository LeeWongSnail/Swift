//
//  ArtScanView.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/13.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtScanView: UIView {

    var holePath: UIBezierPath?
    var holePaths: [UIBezierPath]?
    var viewColor: UIColor?

    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context!.clear(rect)
        
        let clipPath = UIBezierPath(rect: self.bounds)
        clipPath.append(self.holePath!)
        
        for path in self.holePaths! {
            clipPath.append(path)
        }
        
        clipPath.usesEvenOddFillRule = true
        clipPath.addClip()
        
        if self.viewColor != nil {
            self.viewColor = UIColor.black
            context?.setAlpha(0.7)
        }
        
        self.viewColor?.setFill()
        clipPath.fill()
        
    }
}
