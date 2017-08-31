//
//  UIView+Art.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/30.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit
import Foundation
public extension UIView {
    
    typealias XYRearrangeNewDataBlock = () -> Void
    
    // MARK:- 关联属性的key
    private struct xy_associatedKeys {
        static var originalDataBlockKey = "xy_originalDataBlockKey"
        static var newDataBlockKey = "xy_newDataBlockKey"
    }
    
    // 定义一个类属性作为闭包的容器，专门存放闭包的属性
    public class BlockContainer: NSObject, NSCopying {
        public func copy(with zone: NSZone? = nil) -> Any {
            return self
        }
        var rearrangeNewDataBlock: XYRearrangeNewDataBlock?
    }
    
    // 定义个一个计算属性，通过OC的运行时获取关联对象和设置关联对象
    private var newDataBlock: BlockContainer? {
        get {
            if let newDataBlock = objc_getAssociatedObject(self, &xy_associatedKeys.newDataBlockKey) as? BlockContainer {
                return newDataBlock
            }
            return nil
        }
        
        // 如果计算属性的setter没有定义表示新值的参数名，则可以用默认值newValue
        set(newValue) {
            objc_setAssociatedObject(self, xy_associatedKeys.newDataBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    
    // 通过外界调用便利构造函数时，给闭包属性赋值
    
//    convenience init(newDataBlock:  @escaping XYRearrangeNewDataBlock) {
//        self.init()
//        
//        // 创建blockContainer,将外界传来的闭包赋值给类属性中的闭包变量
//        let blockContainer: BlockContainer = BlockContainer()
//        blockContainer.rearrangeNewDataBlock = newDataBlock
//        self.newDataBlock = blockContainer
//    }
//    convenience init (param:String) {
//        self.init()
//        
//    }
    
    
    
        func viewDidTap() -> Void {
            if let block1 = self.newDataBlock {
                block1.rearrangeNewDataBlock!()
            }
            print(newDataBlock)
        }
    
    
        func art_whenTap(block:@escaping XYRearrangeNewDataBlock) -> Void {
            let blockContainer: BlockContainer = BlockContainer()
            blockContainer.rearrangeNewDataBlock = block
            self.newDataBlock = blockContainer
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.viewDidTap)))
            
        }
}




extension UIView {


    
//    func viewDidTap() -> Void {
//        if let block = newDataBlock {
//            
//        }
//    }
//    
//    
//    func art_whenTap(block:@escaping actionBlock) -> Void {
//        newDataBlock = block
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.viewDidTap)))
//        
//    }
    
}
