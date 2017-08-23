//
//  ArtWorkCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/8/16.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit


class ArtWorkCell: UITableViewCell {

    func buildUI() -> Void {
        self.contentView.addSubview(iconImage)
        iconImage.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView.snp.left)
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.width.height.equalTo(35)
        })
        
        self.contentView.addSubview(nickname)
        nickname.snp.makeConstraints({ (make) in
            make.left.equalTo(iconImage.snp.right).offset(10)
            make.top.equalTo(iconImage.snp.top)
        })
        
        self.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints({ (make) in
            make.bottom.equalTo(iconImage.snp.bottom)
            make.left.equalTo(iconImage.snp.right).offset(10)
        })
        
        self.contentView.addSubview(tagBtn)
        tagBtn.snp.makeConstraints ({ (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.top.equalTo(iconImage.snp.top)
            make.width.equalTo(60)
            make.height.equalTo(25)
        })
        
    }
    
    
    func configWorkCell(work:ArtWork) -> Void {
        iconImage.art_setImageWithURL(imageURL: work.author?.icon)
        nickname.text = work.author?.nickname
        detailLabel.text = work.author?.desc
        tagBtn.setTitle(work.work?.sortsname?.last, for: UIControlState.normal)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK: - Lazy Load
    lazy var iconImage: ArtImageView = {
        var tempImage = ArtImageView()
        return tempImage
    }()
    
    lazy var nickname: UILabel = {
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        return tempLabel
    }()
    
    lazy var detailLabel: UILabel = {
        var tempLabel = UILabel()
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        tempLabel.textColor = UIColor.black
        return tempLabel
    }()
    
    lazy var tagBtn:UIButton = {
        var tempBtn = UIButton(type: UIButtonType.custom)
        tempBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return tempBtn
    }()
    
    lazy var contentLabel: UILabel = {
        var tempLabel = UILabel()
        
        tempLabel.font = UIFont.systemFont(ofSize: 15)
        tempLabel.textColor = UIColor.black
        
        return tempLabel
    }()
    
}
