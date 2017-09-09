//
//  ArtMaterilCell.swift
//  DesignBox
//
//  Created by LeeWong on 2017/9/8.
//  Copyright © 2017年 LeeWong. All rights reserved.
//

import UIKit



class ArtMaterilCell: UICollectionViewCell {

//    let kFontSize = 12
//    let  kLeftRightMargin = 7
//    let kBottomToolbarHeight = 32.0
//    let kTitleHeight = 44.0
    
    func buildUI() -> Void {
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(7)
            make.left.equalTo(self.contentView.snp.left).offset(7)
            make.right.equalTo(self.contentView.snp.right).offset(-7)
            make.height.equalTo(44.0)
        }
        
        
        let width = ArtMaterilCell.widthForContent()/2.0
        self.contentView.addSubview(self.viewCountBtn)
        self.viewCountBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.width.equalTo(width)
            make.height.equalTo(32)
        }
        
        self.contentView.addSubview(self.cloudBtn)
        self.cloudBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.viewCountBtn.snp.right)
            make.right.equalTo(self.contentView.snp.right)
            make.width.height.equalTo(self.viewCountBtn)
            make.centerY.equalTo(self.viewCountBtn)
        }
        
        self.contentView.addSubview(self.sepLine)
        self.sepLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(0.5)
            make.top.equalTo(self.viewCountBtn.snp.top)
        }
        
    }
    
    
    
    func configMaterialCell(material:ArtMaterial?) -> Void {
        
        let imageInfo = material?.imgs?.first
        if (imageInfo != nil) {
            let imgwidth = (imageInfo as! [String:AnyObject])["imgwidth"] as! CGFloat
            let imgheight = (imageInfo as! [String:AnyObject])["imgheight"] as! CGFloat
            let height = ArtMaterilCell.heightForImageSize(size: CGSize(width: imgwidth, height: imgheight))
            self.imageView.snp.remakeConstraints({ (make) in
                make.top.left.right.equalTo(self.contentView)
                make.height.equalTo(height)
            })
            
            if let imgurl = (imageInfo as! [String:AnyObject])["imgurl"] {
                self.imageView.art_setImageWithURL(imageURL: imgurl as? String)
            } else {
                self.imageView.art_setImageWithURL(imageURL: nil)
            }
            
        } else {
            let imgwidth = (imageInfo as! [String:AnyObject])["imgwidth"] as! CGFloat
            let imgheight = (imageInfo as! [String:AnyObject])["imgheight"] as! CGFloat
            let height = ArtMaterilCell.heightForImageSize(size: CGSize(width: imgwidth, height: imgheight))
            self.imageView.snp.remakeConstraints({ (make) in
                make.top.left.right.equalTo(self.contentView)
                make.height.equalTo(height)
            })
            
            self.imageView.art_setImageWithURL(imageURL: nil)
        }
        
        
        self.titleLabel.text = material?.name
        if (material?.viewcount)! > 0 {
            self.viewCountBtn.setTitle(String.init(format: "%tu", material!.viewcount!), for: UIControlState.normal)
        } else {
            self.viewCountBtn.setTitle("0", for: UIControlState.normal)
        }
        self.cloudBtn.setTitle(String.init(format: "%tu", material!.keep!), for: UIControlState.normal)
        
    }
    
    class func heightForImageSize(size:CGSize) -> CGFloat {
        let maxWidth = widthForContent()
        return ArtStyle.shared.art_caculateWorkImageSize(width: maxWidth, size: size).height
    }
    
    class func widthForContent() -> CGFloat {
        return (UIScreen.main.bounds.size.width - 3*10)/2;
    }
    
    
    class func sizeForMaterial(material:ArtMaterial?) -> CGSize {
        var imgHeight = 100
        guard material != nil else {
            return CGSize(width: widthForContent(), height: CGFloat(44 + imgHeight + 32))
        }
        
        let imageinfo = material?.imgs?.first
        let imgW = (imageinfo as! [String:AnyObject])["imgwidth"] as! CGFloat
        let imgH = (imageinfo as! [String:AnyObject])["imgheight"] as! CGFloat
        imgHeight = Int(ArtMaterilCell.heightForImageSize(size: CGSize(width: imgW, height: imgH)))
        
        return CGSize(width: widthForContent(), height: CGFloat(44 + imgHeight + 32))
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: LAZY LOAD
    lazy var cloudBtn = { () -> UIButton in
        let tempBtn = UIButton(type: UIButtonType.custom)
        
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempBtn.setTitleColor(UIColor.art_fontGrayColor(), for: UIControlState.normal)
        tempBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        tempBtn.setImage(UIImage.init(named: "material_not_keep"), for: UIControlState.normal)
        return tempBtn
    }()
    
    lazy var viewCountBtn = { () -> UIButton in 
        let tempBtn = UIButton(type: UIButtonType.custom)
        
        tempBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempBtn.setTitleColor(UIColor.art_fontGrayColor(), for: UIControlState.normal)
        tempBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        tempBtn.setImage(UIImage.init(named: "menu_cell_hotcount"), for: UIControlState.normal)
        
        return tempBtn
    }()
    
    
    lazy var sepLine = { () -> UIView in 
        let sepLine = UIView()
        sepLine.backgroundColor = UIColor.art_sepLineLColor()
        return sepLine
    }()
    
    
    lazy var titleLabel = { () -> UILabel in 
        let tempLabel = UILabel()
        
        tempLabel.font = UIFont.systemFont(ofSize: 12)
        tempLabel.numberOfLines = 2
        tempLabel.textColor = UIColor.art_fontColor()
        tempLabel.clipsToBounds = true
        tempLabel.textAlignment = NSTextAlignment.left
        return tempLabel
    }()
    
    lazy var imageView = { () -> ArtImageView in
        let tempImage = ArtImageView()
        
        return tempImage
    }()

}
