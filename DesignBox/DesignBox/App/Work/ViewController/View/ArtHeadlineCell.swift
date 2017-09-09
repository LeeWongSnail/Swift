//
//  ArtHeadlineCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/9.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit

class ArtHeadlineCell: UITableViewCell {

    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
        self.scrollView.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() -> Void {
        self.contentView.addSubview(self.leftView)
        self.leftView.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.left.bottom.equalTo(self.contentView)
            make.top.equalTo(self.contentView.snp.top).offset(0.5)
        }
        
        self.contentView.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp.right)
            make.top.bottom.right.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.headImageView)
        self.headImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.leftView)
            make.left.equalTo(self.contentView).offset(10)
        }
        
        self.headImageView.image = UIImage.init(named: "daily-of-design")
        
    }
    
    
    

    
    
    class func height() -> CGFloat {
        return 60
    }
    
    
    //MARK: - LAZY LOAD
    lazy var leftView = { () -> UIView in 
        let tempView = UIView()
        
        return tempView
    }()
    
    lazy var headImageView = { () -> UIImageView in 
        let headImage = UIImageView()
        
        return headImage
    }()
    
    
    lazy var scrollView = { () -> ArtMonkeyScrollView in 
        let scrollView = ArtMonkeyScrollView()
        
        return scrollView
    }()

}
