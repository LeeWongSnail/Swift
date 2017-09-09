//
//  ArtHeadlinesCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/9.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

protocol ArtMonkeyScrollViewProtocol {
    func getLineTitle() -> String?
}


class ArtMonkeyScrollView: UIScrollView {

    var linesArray = Array<Array<Any>>()
    var viewsArray = [UIView]()
    var current: Int = 0
    var height: CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.height = ArtHeadlineCell.height()
        self.shuffling()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func shuffling() -> Void {
        let height = self.height
        
        self.setContentOffset(CGPoint.init(x: 0, y: height!*CGFloat(self.current)), animated: true)
   
        self.current += 1
        
        if self.current == self.viewsArray.count {
            self.current = 1
            DispatchQueue.main.async {
                self.setContentOffset(CGPoint.zero, animated: false)
            }
        }
        
        let delay = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.shuffling()
        }
    }
    
    
    
    
    func configHeadLinesCell(lines:[ArtMonkeyScrollViewProtocol]) -> Void {
        self.linesArray.removeAll()
        var first:Array<Any> = Array()
        var tempArray:Array<Any> = Array()
        
        var index = 0
        for line in lines {
            let remainder = index % 2
            if remainder == 0 {
                tempArray = Array()
                tempArray.append(line)
            } else if (remainder == 1) {
                tempArray.append(line)
                self.linesArray.append(tempArray)
            }
            
            if index/2 == 0 {
                first = tempArray
            }
            
            
            index += 1
        }
        
        
        if first.count > 0 {
            self.linesArray.append(first)
        }
        
        createView(lines: self.linesArray)
        
        var idx = 0
        for line in linesArray {
            configView(view: self.viewsArray[idx], lines: line as! [ArtMonkeyScrollViewProtocol])
            
            idx += 1
        }
        
    }
    
    
    
    func configView(view:UIView,lines:[ArtMonkeyScrollViewProtocol]) -> Void {
        var index = 0
        for line in lines {
            let tag = 15001 + index
            let label = view.viewWithTag(tag) as! UILabel
            label.text = line.getLineTitle()
            index += 1
        }
        
    }
    
    
    
    func createView(lines:Array<Any>) -> Void {
        
        if lines.count == self.viewsArray.count {
            return
        }
        
        for view in self.subviews {
            if view.tag > 10000 {
                view.removeFromSuperview()
            }
        }
        
        self.viewsArray.removeAll()
        self.layoutIfNeeded()
        
        let width = SCREEN_W - 60 - 10
        let height = 60
        self.height = CGFloat(height)
        var index = 0
        for _ in lines {
            let view = createGroupView()
            view.frame = CGRect(x: 0, y: height*index, width: Int(width), height: height)
            view.tag = 10000 + index
            self.viewsArray.append(view)
            self.addSubview(view)
            index += 1
        }
        
        self.contentSize = CGSize(width: Int(width), height: Int(height * self.viewsArray.count))
        self.current = 0
        self.contentOffset = CGPoint(x: 0, y: height*self.current)
    }
    
    
    func createGroupView() -> UIView {
        
        let groupView = UIView()
        
        
        let label1 = UILabel()
        label1.font = UIFont.systemFont(ofSize: 13)
        label1.textColor = UIColor.art_fontColor()
        groupView.addSubview(label1)
        
        let imageView1 = UIImageView()
        imageView1.backgroundColor = UIColor.art_colorWithHexString(hexString: "E1E1E1")
        imageView1.clipsToBounds = true
        imageView1.layer.cornerRadius = 2.5
        groupView.addSubview(imageView1)
        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(imageView1.snp.right).offset(5)
            make.bottom.equalTo(groupView.snp.centerY).offset(-3)
            make.right.equalTo(groupView.snp.right)
        }
        imageView1.snp.makeConstraints { (make) in
            make.left.equalTo(groupView.snp.left)
            make.width.height.equalTo(5)
            make.centerY.equalTo(label1)
        }
        
        
        let label2 = UILabel()
        label2.font = UIFont.systemFont(ofSize: 13)
        label2.textColor = UIColor.art_fontColor()
        groupView.addSubview(label2)
        
        let imageView2 = UIImageView()
        imageView2.backgroundColor = UIColor.art_colorWithHexString(hexString: "E1E1E1")
        imageView2.clipsToBounds = true
        imageView2.layer.cornerRadius = 2.5
        groupView.addSubview(imageView2)
        
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(imageView2.snp.right).offset(5)
            make.top.equalTo(groupView.snp.centerY).offset(3)
            make.right.equalTo(groupView.snp.right)
        }
        imageView2.snp.makeConstraints { (make) in
            make.left.equalTo(groupView.snp.left)
            make.width.height.equalTo(5)
            make.centerY.equalTo(label2)
        }

        
        label1.tag = 15001;
        label2.tag = 15002;
        
        return groupView
    }
    
    

}
