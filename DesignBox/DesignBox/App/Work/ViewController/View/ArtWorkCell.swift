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
            make.left.equalTo(self.contentView.snp.left).offset(15)
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
        
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(10)
            make.left.equalTo(iconImage.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
        }
        
        self.contentView.addSubview(sepLine)
        sepLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        addToolBar()
    }
    
    
    func addToolBar() -> Void {
        let count = 4
        let w = SCREEN_W / CGFloat(count)
        var view:UIView?
        
        for index in 0...3 {
            let btn = createButtonAtIndex(index: index)
            self.contentView.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                if let leftV = view {
                    make.left.equalTo(leftV.snp.left)
                } else {
                    make.left.equalTo(self.contentView.snp.left)
                }
                make.width.equalTo(w)
                make.bottom.equalTo(self.contentView.snp.bottom)
                make.height.equalTo(37)
            })
            
            if !(index == count - 1)  {
                let sepView = UIView()
                sepView.backgroundColor = UIColor.art_colorWithHexString(hexString: "d9d9d9")
                self.contentView.addSubview(sepView)
                sepView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(btn)
                    make.width.equalTo(0.5)
                    make.left.equalTo(btn.snp.right).offset(0.5)
                })
                view = sepView
            }
            
        }

    }
    
    
    
    func createButtonAtIndex(index:Int) -> UIButton {
        let btn = UIButton(type: UIButtonType.custom)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.art_colorWithHexString(hexString: "999999"), for: UIControlState.normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        
        switch index {
        case 0:
            btn.setImage(UIImage.init(named: "menu_cell_hotcount"), for: UIControlState.normal)
            break
        case 1:
            btn.setImage(UIImage.init(named: "menu_cell_comments"), for: UIControlState.normal)

            break
        case 2:
            btn.setImage(UIImage.init(named: "menu_cell_zan"), for: UIControlState.normal)
            btn.setImage(UIImage.init(named: "menu_cell_has_zan"), for: UIControlState.highlighted)
            btn.setImage(UIImage.init(named: "menu_cell_has_zan"), for: UIControlState.selected)

            break
        case 3:
            btn.setImage(UIImage.init(named: "menu_cell_fav"), for: UIControlState.normal)
            btn.setImage(UIImage.init(named: "menu_cell_has_fav"), for: UIControlState.highlighted)
            btn.setImage(UIImage.init(named: "menu_cell_has_fav"), for: UIControlState.selected)
            break
        default: break
            
        }
        
        return btn
    }
    
    
    
    func configWorkCell(work:ArtWork) -> Void {
        iconImage.art_setImageWithURL(imageURL: work.author?.icon)
        nickname.text = work.author?.nickname
        // 地域＋毕业学院
        var descText:String = ""
        if let workplace = work.author?.workplace {
            descText += workplace
        }
        descText += "   "
        if let school = work.author?.graduation_school  {
            descText += school
        }
        
        detailLabel.text = descText
        tagBtn.setTitle(work.work?.sortsname?.last, for: UIControlState.normal)
        
        contentLabel.text = work.work?.text
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
        tempImage.layer.cornerRadius = 17.5
        tempImage.clipsToBounds = true;
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
//        tempLabel.numberOfLines = 0
        
        return tempLabel
    }()
    
    lazy var sepLine: UIView = {
        var tempLine = UIView()
        tempLine.backgroundColor = UIColor.art_colorWithHexString(hexString: "e3e3e3")
        return tempLine
    }()
    
    
    
}
