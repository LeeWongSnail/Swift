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
        
        self.contentView.addSubview(imageArea)
        imageArea.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(contentLabel.snp.bottom)
            make.height.equalTo(100)
        }
        
         addToolBar()
        
        self.contentView.addSubview(sepLine)
        sepLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-40)
            make.height.equalTo(0.5)
        }
        

        
        
       
    }
    
    
    //MARK: - 底部的工具栏
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
    
    
    func calculateImageCenterAtIndex(index:UInt) -> CGPoint {
        let y = index/3
        let x = index%3
        let centerX = Float(x) * (ArtStyle.shared.art_workGridImageWidth + 5) + 5 + ArtStyle.shared.art_workGridImageWidth/2.0;
        let centerY = Float(y) * (ArtStyle.shared.art_workGridImageWidth + 5) + ArtStyle.shared.art_workGridImageWidth/2.0;
        
        
        var point: CGPoint = CGPoint()
        point.x = CGFloat(centerX)
        point.y = CGFloat(centerY)
        return point
    }
    
    func configImageGridView(work:ArtWorkPaint?) -> Void {
        for  view in imageArea.subviews {
            view.removeFromSuperview()
        }
        
        
        if work?.imgs?.count == 0 {
            imageArea.snp.makeConstraints({ (make) in
                make.width.height.equalTo(0)
                make.top.left.equalTo(self.contentView)
            })
            return
        }
        
        for index in 0...work!.imgs!.count-1 {
            let paintImage = ArtImageView()
            let image:[String:AnyObject] = work?.imgs![index] as! [String : AnyObject]
            paintImage.art_setImageWithURL(imageURL: image["imgurl"] as? String)
            var imageSize = CGSize()
            imageSize.width = CGFloat(ArtStyle.shared.art_workGridImageWidth)
            imageSize.height = CGFloat(ArtStyle.shared.art_workGridImageWidth)
            paintImage.frame.size = imageSize
            paintImage.center = calculateImageCenterAtIndex(index: UInt(index))
            imageArea.addSubview(paintImage)
            
        }
        
        //设置imageArea
        let row = (work?.imgs?.count)!/3
        let column = (work?.imgs?.count)!%3
        let height = (ArtStyle.shared.art_workGridImageWidth + 5) * (Float(row) + Float(column == 0 ? 0 : 1))
        imageArea.snp.remakeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.height.equalTo(height)
        }
        
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
        
        configImageGridView(work: work.work)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public class func cellHeight(work:ArtWork) -> CGFloat {
//        if  work.workCellHeight > Float(0.0)  {
//            return CGFloat(work.workCellHeight)
//        }
        let row = (work.work?.imgs?.count)!/3
        let column = (work.work?.imgs?.count)!%3
        //图片的高度
        var height = (ArtStyle.shared.art_workGridImageWidth + 5) * (Float(row) + Float(column == 0 ? 0 : 1))
        
        //文本的高度
        height += (work.work?.text?.getTextHeigh(font: UIFont.systemFont(ofSize: 15), width: SCREEN_W-30))!
        
        //作者部分
        height += 50
        
        //底部工具栏
        height += 65
        
        work.workCellHeight = height
        return CGFloat(height);
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
        tempLabel.numberOfLines = 0
        
        return tempLabel
    }()
    
    lazy var sepLine: UIView = {
        var tempLine = UIView()
        tempLine.backgroundColor = UIColor.art_colorWithHexString(hexString: "e3e3e3")
        return tempLine
    }()
    
    
    lazy var imageArea:UIView = {
        var tempView = UIView()
        return tempView
    }()
}
